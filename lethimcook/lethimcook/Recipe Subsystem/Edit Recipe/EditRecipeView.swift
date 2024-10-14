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
            if let selectedPhotoData = editRecipeViewModel.customImageData,
               let uiImage = UIImage(data: selectedPhotoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
                            
            PhotosPicker(selection: $selectedPhoto,
                         matching: .images,
                         photoLibrary: .shared()) {
                Label("Add Image", systemImage: "photo")
            }
            
            Button {
                Task {
                    await editRecipeViewModel.getSingleImage(title: editRecipeViewModel.title)
                }
            } label: {
                Label("Add Stock Image", systemImage: "photo")
                    .foregroundStyle(.blue)
            }
            
            if editRecipeViewModel.customImageData != nil {
                Button(role: .destructive) {
                    withAnimation {
                        selectedPhoto = nil
                        editRecipeViewModel.customImageData = nil
                    }
                } label: {
                    Label("Remove Image", systemImage: "xmark")
                        .foregroundStyle(.red)
                }
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                editRecipeViewModel.customImageData = data
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
