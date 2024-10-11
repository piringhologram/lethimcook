//
//  RecipeCardView.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @Environment(Model.self) private var model: Model
    var id: Recipe.ID
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image(model.recipe(id)?.image ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height * 0.5,
                           alignment: .center)
                    .clipped()
                    .cornerRadius(22)
                VStack {
                    Text(model.recipe(id)?.title ?? "")
                        .font(.system(size: 34, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    Text("Ingredients")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    Text(model.recipe(id)?.ingredients ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    Text("Instructions")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    Text(model.recipe(id)?.instructions ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview("RecipeCardView Previews") {
    let model: Model = MockModel()
    
    NavigationStack {
        RecipeDetailView(id: model.recipes[0].id)
    }.environment(model)
}