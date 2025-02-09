//
//  RecipeRowView.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            AsyncImage(url: URL(string: recipe.photoURLSmall ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
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
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)

                Text(recipe.cuisine)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
        .padding(.vertical, 5)
    }
}
