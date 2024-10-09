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
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(model.recipes) { recipe in
                NavigationLink(value: recipe, label: {
                    ZStack {
                        // TODO : Background for each component
                        VStack {
                            // TODO : image
                            Text(recipe.title)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                    }
                })
            }
        }
        
    }
}

#Preview("RecipeGridView Previews") {
    RecipeGridView()
        .environment(MockModel() as Model)
}
