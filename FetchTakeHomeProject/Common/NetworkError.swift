//
//  NetworkError.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import Foundation

// MARK: - Error Handling
enum NetworkError: Error, Equatable {
    case invalidURL
    case decodingError(String)
    case invalidImageData
    case networkFailure(String)
    case requestFailed(Int, String)
    case timeout
    case unexpectedError(String)
}

// MARK: - Localized Error Description
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid. Please check the API endpoint."
        case .decodingError(let message):
            return "Failed to decode response: \(message)"
        case .invalidImageData:
            return "The image data is invalid. Unable to load image."
        case .networkFailure(let message):
            return "Network request failed: \(message)"
        case .requestFailed(let statusCode, let message):
            return "Request failed with status code \(statusCode): \(message)"
        case .timeout:
            return "The request timed out. Please try again."
        case .unexpectedError(let message):
            return "An unexpected error occurred: \(message)"
        }
    }
}
