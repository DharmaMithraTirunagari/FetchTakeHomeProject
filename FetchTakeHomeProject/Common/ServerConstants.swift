//
//  ServerConstants.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//


import Foundation

// MARK: - Server Constants
enum ServerConstants {
    static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    static let recipesURL = "\(baseURL)recipes.json"
    static let malformedRecipesURL = "\(baseURL)recipes-malformed.json"
    static let emptyRecipesURL = "\(baseURL)recipes-empty.json"
    
    // Timeout for network requests
    static let requestTimeout: TimeInterval = 15.0
}
