//
//  HintView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/19/24.
//

import SwiftUI

struct HintView: View {
    @Binding var showHint: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            TextBubbleView()
            
            Button("Got it!") {
                withAnimation {
                    showHint = false
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            Spacer().frame(height: 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
    }
}

struct TextBubbleView: View {
   
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hello, I am Aashi! 👋🏻")
                .font(.headline)
                .fontWeight(.bold)
            Text("Welcome to Fetch iOS-coding-challenge!")
                .font(.subheadline)
                .fontWeight(.bold)
            Text("This is the Home Screen with - Dessert list in alphabetical order. Tap on a dessert to see instructions on how to make it.")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}



#Preview {
    HintView(showHint: .constant(true))
}
