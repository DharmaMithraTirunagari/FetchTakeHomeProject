//
//  ContentView.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        RecipeListView()
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(RecipeViewModel(networkManager: MockApiService())) 
}
