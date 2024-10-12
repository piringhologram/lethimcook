//
//  RecipeCardView.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct RecipeView: View {
    @Environment(Model.self) private var model: Model
    @Environment(\.dismiss) private var dismiss
    var id: Recipe.ID
    
    @State private var editSheetOpen = false
    @State private var optionPopoverOpen = false
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        RecipeDetailView(id: id)
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        editSheetOpen.toggle()
//                    }, label: {
//                        Image(systemName: "x.circle.fill").resizable()
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(Color.gray)
//                    })
//                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(action: {
                            editSheetOpen.toggle()
                        }, label: {
                            Text("Edit Recipe")
                        })
                        Button(action: {
                            // DELETE RECIPE HERE
                            showDeleteConfirmation.toggle()
                        }, label: {
                            Text("Delete Recipe")
                                .foregroundStyle(.red)
                        })
                    }, label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    })
                }
            }
            .sheet(isPresented: $editSheetOpen, content: {
                EditRecipeView(self.model, id: id)
            })
            .confirmationDialog("Are you sure you want to delete this recipe ?",
                                isPresented: $showDeleteConfirmation,
                                titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    Task {
                        await deleteRecipe()
                        dismiss()
                    }
                }
                Button("Cancel", role: .cancel) {
                }
            }
        }
    private func deleteRecipe() async {
        await model.delete(recipeId: id)
    }
    }


#Preview("RecipeView Previews") {
    let model: Model = MockModel()
    
    NavigationStack {
        RecipeView(id: model.recipes[2].id)
    }.environment(model)
}
