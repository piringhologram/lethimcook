//
//  RecipeCardView.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct RecipeView: View {
    @Environment(Model.self) private var model: Model
    var id: Recipe.ID
    
    @State private var editSheetOpen = false
    @State private var optionPopoverOpen = false
    
    var body: some View {
        RecipeDetailView(id: id)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        editSheetOpen.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill").resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.gray)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(action: {
                            editSheetOpen.toggle()
                        }, label: {
                            Text("Edit Recipe")
                        })
                        Button(action: {
                            editSheetOpen.toggle()
                        }, label: {
                            Text("Delete Recipe")
                                .foregroundStyle(.red)
                        })
                    }, label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.gray)
                    })
                }
            }
            .sheet(isPresented: $editSheetOpen, content: {
                EditRecipeView(self.model, id: id)
            })
        }
    }

#Preview("RecipeView Previews") {
    let model: Model = MockModel()
    
    NavigationStack {
        RecipeView(id: model.recipes[2].id)
    }.environment(model)
}
