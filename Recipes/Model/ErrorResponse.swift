//
//  ErrorResponse.swift
//  Recipes
//
//  Created by Paul Smith on 12/14/24.
//

import Foundation

struct ErrorResponse : Codable {
    let error: String
    let status: Int
}

extension ErrorResponse : LocalizedError {
    var errorDescription: String? {
        return error
    }
}
