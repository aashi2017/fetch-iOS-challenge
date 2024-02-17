//
//  SwiftUIView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/16/24.
//

import SwiftUI

struct MealDetailView: View {
    var meal: MealDetail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Meal Image
                AsyncImage(url: meal.strMealThumb) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()

                // Meal Name
                Text(meal.strMeal)
                    .font(.title2)
                    .fontWeight(.bold)

                // Divider
                Divider()

                // Instructions Title
                Text("Instructions")
                    .font(.headline)
                    .padding(.bottom, 5)

                // Instructions Content
                Text(meal.strInstructions)
                    .font(.body)
                    .padding(.bottom, 10)

                // Ingredients and Measurements Title
                Text("Ingredients")
                    .font(.headline)
                    .padding(.bottom, 5)

                // Ingredients and Measurements List
                ForEach(meal.ingredientsAndMeasures, id: \.self) { ingredient in
                    Text(ingredient)
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle(meal.strMeal)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MealDetailView(meal: <#MealDetail#>)
}
