//
//  HintView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/19/24.
//
//

//This view represnts custom hint view component, designed to display a hint or instructional overlay to the user. 

import SwiftUI

struct HintView: View {
    @Binding var showHint: Bool
    let title: String
    let subtitle: String
    let description: String
    
    var body: some View {
        VStack {
            Spacer()
            
            TextBubbleView(title: title, subtitle: subtitle, description: description)
            
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
    let title: String
    let subtitle: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            Text(subtitle)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(description)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

// Usage in previews or in other views throughout your app
struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        HintView(
            showHint: .constant(true),
            title: "Hello, I am Aashi! 👋🏻",
            subtitle: "Welcome to Fetch iOS-coding-challenge!",
            description: "This is the Home Screen with - Dessert list in alphabetical order. Tap on a dessert to see instructions on how to make it."
        )
    }
}
