//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Paul Smith on 12/13/24.
//

import Testing
@testable import Recipes

struct RecipesTests {

    @Test func testData() async throws {
        APIClient.getRecipes(url: APIClient.Endpoints.getRecipes.url, completion: {recipes, error in
            #expect(recipes?.count ?? 0 > 0)
        })
    }
    
    @Test func testEmptyData() async throws {
        APIClient.getRecipes(url: APIClient.Endpoints.getEmptyData.url, completion: {recipes, error in
            #expect(recipes?.isEmpty ?? false)
        })
    }
    
    @Test func testMalformedData() async throws {
        APIClient.getRecipes(url: APIClient.Endpoints.getMalformedData.url, completion: {recipes, error in
            #expect(error != nil)
        })
    }

}
