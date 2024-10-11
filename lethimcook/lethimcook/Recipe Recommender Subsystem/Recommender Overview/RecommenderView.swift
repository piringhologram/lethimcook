//
//  RecommenderView.swift
//  lethimcook
//
//  Created by ipraktikum on 10.10.24.
//
import SwiftUI

struct RecommenderView: View {
    @Environment(Model.self) private var model: Model
    
    var body: some View {
        Text("Coming Soon!")
    }
}

#Preview {
    RecommenderView()
        .environment(MockModel() as Model)
}
