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
        GridItem(.flexible(minimum: 50)),
        GridItem(.flexible(minimum: 50))
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(model.recipes) { recipe in
                NavigationLink(value: recipe, label: {
                    RecipeCardView(recipe: recipe)
                })
            }
        }.padding()
        
    }
}

#Preview("RecipeGridView Previews") {
    RecipeGridView()
        .environment(MockModel() as Model)
}
