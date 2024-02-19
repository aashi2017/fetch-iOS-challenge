//
//  SwiftUIView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/16/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var mealDetailViewModel = MealDetailViewModel()

    var body: some View {
        ScrollView {
            if let mealDetail = mealDetailViewModel.mealDetail {
                VStack(alignment: .leading, spacing: 20) {
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    AsyncImage(url: mealDetail.strMealThumb) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(mealDetail.strInstructions)
                        .font(.body)
                        .padding(.bottom)
                    
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(mealDetail.ingredientsAndMeasures, id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.body)
                    }
                    
                    Spacer()
                }
                .padding()
            } else if mealDetailViewModel.isLoading {
                ProgressView("Loading...")
            } else {
                Text("No recipe available at this time 😞")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Meal Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            mealDetailViewModel.loadMealDetail(mealID: mealID)
        }
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

        MealDetailView(mealID: "53049")
    }
}



