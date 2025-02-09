//
//  NetworkManager.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import Foundation
import UIKit

protocol RecipeApiInterface {
    func fetchRecipes(url: String) async throws -> [Recipe]
    func fetchImage(url: String) async throws -> UIImage
}

class NetworkManager: RecipeApiInterface {
    
    static let shared = NetworkManager()
    
    private let session: URLSession
    private var imageCache = NSCache<NSString, UIImage>()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Fetch Recipes
    func fetchRecipes(url: String) async throws -> [Recipe] {
        guard let serverURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: serverURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed(0, "Invalid response from server.")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(httpResponse.statusCode, "Unexpected response from server.")
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decodedResponse.recipes
        } catch {
            throw NetworkError.decodingError("Failed to decode response: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Image with Caching
    func fetchImage(url: String) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }
        
        if let diskImage = loadImageFromDisk(url: url) {
            imageCache.setObject(diskImage, forKey: url as NSString)
            return diskImage
        }
        
        guard let imageUrl = URL(string: url) else { throw NetworkError.invalidURL }
        
        let (data, _) = try await session.data(from: imageUrl)
        
        guard let image = UIImage(data: data) else { throw NetworkError.invalidImageData }
        
        imageCache.setObject(image, forKey: url as NSString)
        saveImageToDisk(image: image, url: url)
        
        return image
    }
    
    // MARK: - Image Caching to Disk
    private func saveImageToDisk(image: UIImage, url: String) {
        guard let data = image.pngData() else { return }
        let filePath = getFilePath(for: url)
        try? data.write(to: filePath)
    }
    
    private func loadImageFromDisk(url: String) -> UIImage? {
        let filePath = getFilePath(for: url)
        if let data = try? Data(contentsOf: filePath), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    private func getFilePath(for url: String) -> URL {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let filename = url.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "cached_image"
        return cacheDirectory.appendingPathComponent(filename)
    }
}
