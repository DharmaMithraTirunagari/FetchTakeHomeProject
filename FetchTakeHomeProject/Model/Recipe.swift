//
//  Recipe.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import Foundation

// MARK: - Recipe API Models
struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

// MARK: - Validation Logic
extension Recipe {
    var isValid: Bool {
        return !id.isEmpty && !name.isEmpty && !cuisine.isEmpty
    }
}
