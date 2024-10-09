//
//  RecipeOverviewView.swift
//  lethimcook
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

struct RecipeOverviewView: View {
    
    @State private var isDarkMode = false
    
    @Environment(Model.self) private var model: Model
    
    var body: some View {
        NavigationStack {
            
            ScrollView(.vertical){
                RecipeGridView()
            }
            .navigationBarTitle("Recipe Gallery")
            .toolbar {
                ToolbarItem(placement:
                        .primaryAction) {
                            Button(action: {},
                                   label: {
                                Image(systemName: "plus")
                            })
                        }
                ToolbarItem {
                    Toggle(isOn: $isDarkMode,
                           label: {
                            Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                           })                }
            }
        }
        
        .padding()
    }
}

#Preview {
    RecipeOverviewView()
        .environment(MockModel() as Model)
}
