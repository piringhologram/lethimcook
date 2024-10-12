//
//  RecipeCardView.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    
    private var imageViewSection: some View {
        ZStack {
            if let customImageData = recipe.customImageData,
               let customImage = UIImage(data: customImageData) {
                    Image(uiImage: customImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.43, height: 135)
                        .clipped()
            } else if let imageURL = recipe.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.43, height: 135)
                            .clipped()
                    case .failure(_):
                        Text("Failed to load image")
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
//                let recipe3 = "recipe1"
//                let imageData3 = UIImage(named: recipe3)?.pngData()
//                
//                let customImage = UIImage(data: imageData3!)
//                Image(uiImage: customImage!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: UIScreen.main.bounds.width * 0.43, height: 135)
//                    .clipped()
                Text("NO IMAGE")
                    .frame(width: UIScreen.main.bounds.width * 0.43, height: 135)
//                Image(recipe.image ?? "")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: UIScreen.main.bounds.width * 0.43, height: 135)
//                    .clipped()
            }
        }
    }
    
    var body: some View {
        VStack {
            imageViewSection
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
    let recipe3 = "recipe1"
    let imageData3 = UIImage(named: recipe3)?.pngData()
    RecipeCardView(recipe: Recipe(id: UUID(),
                                  title: "Pasta Carbonara stuff",
                                  ingredients: "Egg and Stuff",
                                  instructons: "Add egg then cook",
                                  image: "recipe3",
//                                  imageURL: URL(string: "https://as2.ftcdn.net/v2/jpg/02/55/81/09/1000_F_255810948_66UuLjLvvEDjQ93KkDozf8ruTrEeKFtH.jpg"),
                                  customImageData: imageData3
                                 ))
}
