//
//  EditRecipeView.swift
//  lethimcook
//
//  Created by ipraktikum on 10.10.24.
//

import SwiftUI

struct EditRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var editRecipeViewModel: EditRecipeViewModel
    
    init(_ model: Model, id: Recipe.ID) {
        self._editRecipeViewModel = State(wrappedValue: EditRecipeViewModel(model, id: id))
    }
    var formView: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Recipe", text: $editRecipeViewModel
                    .title)
            }
            Section(header: Text("Ingredients")) {
                TextEditor(text: $editRecipeViewModel
                    .ingredients)
            }
            Section(header: Text("Instructions")) {
                TextEditor(text: $editRecipeViewModel
                    .instructions)
            }
            Section(header: Text("Image")) {
                TextField("Image", text: $editRecipeViewModel
                    .image)
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
