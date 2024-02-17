//
//  SwiftUIView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/16/24.
//

import SwiftUI

struct MealDetailView: View {
    let meal: MealDetail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(meal.strMeal)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                AsyncImage(url: meal.strMealThumb) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(12)
                .padding()

                Text("Instructions")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text(meal.strInstructions)
                    .font(.body)
                    .padding(.bottom)

                Text("Ingredients")
                    .font(.headline)
                    .padding(.bottom, 5)

                ForEach(meal.ingredientsAndMeasures, id: \.self) { ingredient in
                    Text(ingredient)
                        .font(.body)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Recipe", displayMode: .inline)
    }
}


// For previews
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMealDetail = MealDetail(
            idMeal: "53049",
            strMeal: "Apam balik",
            strInstructions: "Mix milk...",
            strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!,
            ingredients: ["Milk", "Oil", "Eggs", "Flour", "Baking Powder", "Salt", "Unsalted Butter", "Sugar", "Peanut Butter"],
            measures: ["200ml", "60ml", "2", "1600g", "3 tsp", "1/2 tsp", "25g", "45g", "3 tbs"]
        )

        MealDetailView(meal: sampleMealDetail)
    }
}



