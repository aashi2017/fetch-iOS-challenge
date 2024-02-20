//
//  DesertRowView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/19/24.
//
//This view defines a row view for displaying a dessert. It consists of an asynchronous image loader for the dessert's thumbnail and the dessert's name text.
import SwiftUI

struct DessertRowView: View {
    let dessert: Meal
    
    
    var body: some View {
        HStack {
            AsyncImage(url: dessert.strMealThumb) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(5)
            
            Text(dessert.strMeal)
        }
    }
}

