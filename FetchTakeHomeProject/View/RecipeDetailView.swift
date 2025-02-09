//
//  RecipeDetailView.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//


import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: recipe.photoURLLarge ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()

                VStack(alignment: .leading, spacing: 15) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Cuisine: \(recipe.cuisine)")
                        .font(.title3)
                        .foregroundColor(.gray)

                    if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                        Button(action: {
                            UIApplication.shared.open(url)
                        }) {
                            Text("View Full Recipe")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                        Button(action: {
                            UIApplication.shared.open(url)
                        }) {
                            Text("Watch on YouTube")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()
            }
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
