//
//  Cuisine.swift
//  Recipes
//
//  Created by Paul Smith on 12/14/24.
//

import Foundation

class Cuisine: Identifiable {
    let id = UUID()
    var name: String = "Unknown"
    var recipes: [Recipe] = []
    
    init(name: String, recipes: [Recipe]) {
        self.name = name
        self.recipes = recipes
    }
}
