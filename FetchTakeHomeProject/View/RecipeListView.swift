//
//  RecipeListView.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel(networkManager: NetworkManager.shared)
    @State private var searchText = ""

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return viewModel.recipes
        }
        return viewModel.recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var groupedRecipes: [String: [Recipe]] {
        Dictionary(grouping: filteredRecipes, by: { $0.cuisine })
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                // Main Content
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                        .scaleEffect(1.5)
                } else if let errorMessage = viewModel.errorMessage {
                    EmptyStateView(message: errorMessage, onRetry: {
                        viewModel.fetchData()
                    })
                } else if groupedRecipes.isEmpty {
                    EmptyStateView(message: "No recipes available", onRetry: nil)
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(groupedRecipes.keys.sorted(), id: \.self) { cuisine in
                                // Styled Header for Cuisine
                                HStack {
                                    Text(cuisine.capitalized)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(8)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                                    Spacer()
                                }
                                .padding(.horizontal)

                                // Recipe Rows for Each Cuisine
                                ForEach(groupedRecipes[cuisine] ?? []) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        RecipeRowView(recipe: recipe)
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .refreshable {
                        viewModel.fetchData()
                    }
                }
            }
            .navigationTitle("Recipe Explorer")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.fetchData()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                if viewModel.recipes.isEmpty {
                    viewModel.fetchData()
                }
            }
        }
    }
}


