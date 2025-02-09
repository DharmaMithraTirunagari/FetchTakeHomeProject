//
//  RecipeViewModel.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//


import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let networkManager: RecipeApiInterface
    
    init(networkManager: RecipeApiInterface) {
        self.networkManager = networkManager
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let storedData = try await networkManager.fetchRecipes(url: ServerConstants.recipesURL)
                
                if storedData.isEmpty {
                    errorMessage = "No recipes available."
                }
                
                DispatchQueue.main.async {
                    self.recipes = storedData
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func fetchImage(url: String) async -> UIImage? {
        do {
            async let image = try networkManager.fetchImage(url: url)
            return try await image
        } catch {
            print("Failed to fetch image: \(error.localizedDescription)")
            return nil
        }
    }

}
