//
//  RecipeOverviewView.swift
//  lethimcook
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

struct RecipeOverviewView: View {
    
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView(.vertical){
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello World")
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
}
