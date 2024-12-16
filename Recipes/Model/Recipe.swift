//
//  Recipe.swift
//  Recipes
//
//  Created by Paul Smith on 12/14/24.
//

struct Recipe: Hashable, Identifiable, Codable {
    let cuisine: String
    let name: String
    let photo_url_large: String?
    let photo_url_small: String?
    let id: String
    let source_url: String?
    let youtube_url: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case id = "uuid"
        case source_url
        case youtube_url
    }
}
