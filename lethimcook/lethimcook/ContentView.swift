//
//  ContentView.swift
//  lethimcook
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

struct ContentView: View {
    /// Declare `Model` the `Recipe` will be read from
    @Environment(Model.self) private var model: Model
    
    var body: some View {
        TabView {
            RecipeOverviewView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Recipes")
                }
            RecommenderView()
                .tabItem {
                    Image(systemName: "person.crop.circle.badge.plus")
                    Text("Recommender")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(MockModel() as Model)
}
