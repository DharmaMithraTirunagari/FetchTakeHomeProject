//
//  FetchTakeHomeProjectApp.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import SwiftUI

@main
struct Fetch_RecipeProjectApp: App {
    private let useMockAPI = false  

    @StateObject private var viewModel: RecipeViewModel

    init() {
        let apiService: RecipeApiInterface = useMockAPI ? MockApiService() : NetworkManager.shared
        _viewModel = StateObject(wrappedValue: RecipeViewModel(networkManager: apiService))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
