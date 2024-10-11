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
    var loaded = false
    var showSaveProgressView = false
    var showDeleteProgressView = false
    
    var id: Recipe.ID
    
    private var model: Model?
    
    var recipes: [Recipe] {
        model?.recipes ?? []
    }
    
    var disableSaveButton: Bool {
        title.isEmpty || ingredients.isEmpty || instructions.isEmpty || image.isEmpty
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
        self.image = recipe.image
        
        self.loaded = true
    }
    
    func save() async {
        guard let model = model else {
            return
        }
        let recipe = Recipe(id: self._id,
                            title: self.title,
                            ingredients: self.title,
                            instructons: self.title,
                            image: self.image)
        DispatchQueue.main.async {
            self.showSaveProgressView = true
        }
        do {
            try await model.save(recipe)
        } catch {
            print("Unexpected error: \(error)")
        }
        
        DispatchQueue.main.async {
            self.updateStates()
            self.showSaveProgressView = false
        }
    }
}
