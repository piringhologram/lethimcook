//
//  RecommenderView.swift
//  lethimcook
//
//  Created by ipraktikum on 10.10.24.
//
import SwiftUI
import ConfettiView
import os

struct RecommenderView: View {
    @State private var showConfetti = false
    @Environment(Model.self) private var model: Model
    private let logger = Logger(subsystem: "com.christiandevin.lethimcook", category: "RecommenderView")
    
    var body: some View {
        VStack {
            Spacer()
            Text("Coming Soon!")
                .font(.custom("BaksoSapi", size: 30))
            Button(action: {
                triggerConfetti() }) {
                Text("hmm?")
                    .font(.custom("Onest-Bold", size: 12))
            }
            Spacer()
        }
        .overlay(
            showConfetti ? ConfettiView(confetti: [
                .text("😻"),
                .text("🍟"),
                .text("🍱"),
                .text("🙀"),
            ])
            .frame(width: UIScreen.main.bounds.width, height: 200) : nil
       )
    }
    
    private func triggerConfetti() {
        showConfetti = true
        logger.info("Confetti triggered!")
        
        // Turn off confetti after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            showConfetti = false
            logger.info("Confetti stopped after 5 seconds")
        }
    }
}

#Preview {
    RecommenderView()
        .environment(MockModel() as Model)
}
