//
//  RecipeCardView.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            // TODO : image
            Color.gray
                .frame(height: 160)
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                    .frame( maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(minHeight: 150)
        .background(Color.blue)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview("RecipeCardView Previews") {
    RecipeCardView(recipe: Recipe(id: UUID(),
                                  title: "Fried Egg",
                                  ingredients: "Egg and Stuff",
                                  instructons: "Add egg then cook"))
}
