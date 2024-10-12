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
            ZStack {
                Image(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.43, height: 135)
                    .clipped()
            }
            .overlay(alignment: .bottomLeading) {
                Button {
                    // TODO
                } label: {
                    Image(systemName: "heart.circle.fill")
                        .foregroundColor(.white)
                        .padding(12)
                }
            }
            Text(recipe.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
                .multilineTextAlignment(.leading)
        }
        .background(Color(.tertiarySystemFill))
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width * 0.43, height: 200)
    }
}

#Preview("RecipeCardView Previews") {
    RecipeCardView(recipe: Recipe(id: UUID(),
                                  title: "Pasta Carbonara stuff",
                                  ingredients: "Egg and Stuff",
                                  instructons: "Add egg then cook",
                                  image: "recipe2"))
}
