//
//  ContentView.swift
//  lethimcook
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RecipeOverviewView()
    }
}

#Preview {
    ContentView()
        .environment(MockModel() as Model)
}
