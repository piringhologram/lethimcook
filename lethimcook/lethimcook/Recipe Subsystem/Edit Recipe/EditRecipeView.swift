//
//  EditRecipeView.swift
//  lethimcook
//
//  Created by ipraktikum on 10.10.24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct EditRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var editRecipeViewModel: EditRecipeViewModel
    
    @State private var selectedPhoto: PhotosPickerItem?
    
    @State private var recipeImage: UIImage?
    
    init(_ model: Model, id: Recipe.ID) {
        self._editRecipeViewModel = State(wrappedValue: EditRecipeViewModel(model, id: id))
    }
    
    var formView: some View {
        Form {
            titleSection
            ingredientsSection
            instructionsSection
            imageSection
        }
    }
    
    private var titleSection: some View {
        Section(header: Text("Name")) {
            TextField("Recipe", text: $editRecipeViewModel
                .title)
        }
    }
    
    private var ingredientsSection: some View {
        Section(header: Text("Ingredients")) {
            TextEditor(text: $editRecipeViewModel
                .ingredients)
        }
    }
    
    private var instructionsSection: some View {
        Section(header: Text("Instructions")) {
            TextEditor(text: $editRecipeViewModel
                .instructions)
        }
    }
    
    private var imageSection: some View {
        Section(header: Text("Image")) {
            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                if let recipeImage = recipeImage {
                    Image(uiImage: recipeImage).resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                } else if let imageURL = editRecipeViewModel.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } placeholder: {
                        Text("Loading image...")
                    }
                } else {
                    Text("Pick an image")
                }
            }
        }
        .onChange(of: selectedPhoto) { _, _ in
            Task {
                if let selectedPhoto,
                   let data = try? await selectedPhoto.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        recipeImage = image
                        editRecipeViewModel.customImageData = data
                    }
            }
                selectedPhoto = nil
            }
        }
    }

    
    var body: some View {
        NavigationStack {
            formView
            .task {
                editRecipeViewModel.updateStates()
            }
            .navigationBarTitle(editRecipeViewModel.id == nil ? "Add Recipe" : "Edit Recipe", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await editRecipeViewModel.save()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .bold()
                    }
                    .disabled(editRecipeViewModel.disableSaveButton)
                }
            }
        }
    }
}

#Preview {
    let model: Model = MockModel()
    
    EditRecipeView(model, id: model.recipes[0].id)
        .environment(model)
}
