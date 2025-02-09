//
//  MockApiService.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import UIKit


class MockApiService: RecipeApiInterface {
    
    var shouldFail = false
    var shouldReturnEmpty = false
    var shouldReturnMalformed = false
    var mockImage: UIImage? // Added mockImage

    func fetchRecipes(url: String) async throws -> [Recipe] {
        if shouldFail {
            throw NetworkError.requestFailed(500, "Server Error")
        }
        if shouldReturnEmpty {
            return []
        }
        if shouldReturnMalformed {
            throw NetworkError.decodingError("Malformed JSON")
        }

        // Return mock recipes
        return [
            Recipe(id: "1", name: "Test Recipe 1", cuisine: "Test Cuisine", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil),
            Recipe(id: "2", name: "Test Recipe 2", cuisine: "Test Cuisine", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
        ]
    }

    func fetchImage(url: String) async throws -> UIImage {
        guard let image = mockImage else {
            throw NetworkError.invalidImageData
        }
        return image
    }
}
