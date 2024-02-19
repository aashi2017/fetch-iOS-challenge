//
//  DesertRowView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/19/24.
//

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

