//
//  RecipeGridView.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct RecipeGridView: View {
    /// Declare `Model` the `Recipe` will be read from
    @Environment(Model.self) private var model: Model
    
    private let columns = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            ForEach(model.recipes) { recipe in
                NavigationLink(value: recipe, label: {
                    RecipeCardView(recipe: recipe)
                })
            }
        }
        .padding()
        .navigationDestination(for: Recipe.self) { recipe in RecipeView(id: recipe.id)
        }
    }
}

#Preview("RecipeGridView Previews") {
    RecipeGridView()
        .environment(MockModel() as Model)
}
