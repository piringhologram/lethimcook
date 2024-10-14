//
//  EditRecipeViewModel.swift
//  lethimcook
//
//  Created by ipraktikum on 10.10.24.
//

import Foundation
import SwiftUI

@Observable class EditRecipeViewModel {
    var title: String = ""
    var ingredients: String = ""
    var instructions: String = ""
    var date = Date()
    var image: String = ""
    var imageURL: URL?
    var customImageData: Data?
    var loaded = false
    var showSaveProgressView = false
    var showDeleteProgressView = false
    
    var id: Recipe.ID
    
    private var model: Model?
    
    var recipes: [Recipe] {
        model?.recipes ?? []
    }
    
    var disableSaveButton: Bool {
        title.isEmpty || ingredients.isEmpty || instructions.isEmpty
    }
    
    init(_ model: Model, id: Recipe.ID) {
        self.model = model
        self.id = id
    }
    
    func updateStates() {
        guard let recipe = model?.recipe(id) else {
            return
        }
        self.title = recipe.title
        self.ingredients = recipe.ingredients
        self.instructions = recipe.instructions
        self.image = recipe.image ?? ""
        self.imageURL = recipe.imageURL
        self.customImageData = recipe.customImageData
        
        self.loaded = true
    }
    
    func save() async {
        guard let model = model else {
            return
        }
        let recipe = Recipe(id: self.id,
                            title: self.title,
                            ingredients: self.ingredients,
                            instructons: self.instructions,
                            image: self.image,
                            imageURL: self.imageURL,
                            customImageData: self.customImageData)
        DispatchQueue.main.async {
            self.showSaveProgressView = true
        }
        do {
            try await model.save(recipe)
//            print("saved")
        } catch {
            print("Unexpected error: \(error)")
        }
        
        DispatchQueue.main.async {
            self.updateStates()
            self.showSaveProgressView = false
        }
    }
    
    func delete() async {
        guard let id = id, let model = model else {
            return
        }
        DispatchQueue.main.async {
            self.showDeleteProgressView = true
        }
        
        await model.delete(recipeId: id)
        
        DispatchQueue.main.async {
            self.updateStates()
            self.showDeleteProgressView = false
        }
    }
    
    func getSingleImage(title: String) async {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=f581767eca6140b481d5a9daefabd995&query=\(title)&number=1"
        
        if let url = URL(string: urlString) {
            do {
                let (data,_) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(ImageResponse.self, from: data)
                
                print(data)
                print(response)
                if let imageUrlString = response.results.first?.image, let imageURL = URL(string: imageUrlString) {
                    let imageData = try await URLSession.shared.data(from: imageURL).0
                    DispatchQueue.main.async {
                        self.customImageData = imageData
                    }
                }
            } catch {
                print("Failed to fetch image: \(error)")
            }
        }
    }
}
