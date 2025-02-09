//
//  EmptyStateView.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    let onRetry: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            
            Text(message)
                .font(.headline)
                .foregroundColor(.gray)
            
            if let onRetry = onRetry {
                Button(action: onRetry) {
                    Text("Retry")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 40)
            }
        }
        .padding()
    }
}

