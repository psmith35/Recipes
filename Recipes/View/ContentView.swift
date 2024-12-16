//
//  ContentView.swift
//  Recipes
//
//  Created by Paul Smith on 12/13/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var cuisines: [Cuisine] = []
    @State private var showingAlert = false
    @State private var errorDescription: String?
    
    var body: some View {
        NavigationView {
            List() {
                if(cuisines.isEmpty) {
                    Text("No Recipes Available").font(.subheadline)
                }
                else {
                    ForEach(cuisines) { cuisine in
                        Section(header: Text(cuisine.name).bold().font(.headline)) {
                            ForEach(cuisine.recipes) { recipe in
                                RecipeView(recipe: recipe)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                Button(action: fetchRecipes) { Text("Refresh") }
            }
        }
        .onAppear{
            fetchRecipes()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(errorDescription ?? "Something went Wrong"), dismissButton: .default(Text("Ok")))
        }
    }
    
    func fetchRecipes() {
        cuisines.removeAll()
        APIClient.getRecipes(url: APIClient.Endpoints.getRecipes.url, completion: {recipes, error in
            if let error = error {
                showingAlert = true
                errorDescription = error.localizedDescription
            }
            if let recipes = recipes {
                for recipe in recipes {
                    if !cuisines.contains(where: { $0.name == recipe.cuisine }) {
                        cuisines.append(Cuisine(name: recipe.cuisine, recipes: [recipe]))
                    }
                    else {
                        cuisines.first(where: { $0.name == recipe.cuisine })?.recipes.append(recipe)
                    }
                }
                cuisines.sort(by: { $0.name < $1.name })
            }
        })
    }
}

struct RecipeView: View {
    var recipe: Recipe

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.photo_url_small!))
            { phase in
                switch phase {
                    case .failure: Image(systemName: "photo") .font(.largeTitle)
                    case .success(let image):
                        image.resizable()
                    default: ProgressView()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(recipe.name).bold().font(.subheadline)
            Spacer()
            if let youtube_url = recipe.youtube_url {
                Link(destination: URL(string: youtube_url)!) {
                    Text("Video").font(.subheadline)
                }
            }
            else if let sourceURL = recipe.source_url {
                Link(destination: URL(string: sourceURL)!) {
                    Text("Website").font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
