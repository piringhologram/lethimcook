//
//  RecipeOverviewView.swift
//  lethimcook
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

struct RecipeOverviewView: View {
    @Environment(Model.self) private var model: Model
    
    @State private var addSheetOpen = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                RecipeGridView()
            }
            .navigationBarTitle("Recipe Gallery")
            .toolbar {
                ToolbarItem(placement:
                        .primaryAction) {
                            Button(action: {
                                addSheetOpen.toggle()
                            }, label: {
                                Image(systemName: "plus")
                            })
                }
            }
            .sheet(isPresented: $addSheetOpen, content: {
                EditRecipeView(self.model, id: nil)
            })
        }
        .padding(5)
    }
}

#Preview {
    RecipeOverviewView()
        .environment(MockModel() as Model)
}
