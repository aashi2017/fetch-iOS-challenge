//
//  SwiftUIView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/16/24.
//

import SwiftUI

//struct MealDetailView: View {
//    let mealID: String
//    @StateObject private var mealDetailViewModel = MealDetailViewModel()
//
//    var body: some View {
//        ScrollView {
//            if let mealDetail = mealDetailViewModel.mealDetail {
//                VStack(alignment: .leading, spacing: 20) {
//                    Text(mealDetail.strMeal)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                    
//                    AsyncImage(url: mealDetail.strMealThumb) { image in
//                        image.resizable()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .aspectRatio(contentMode: .fit)
//                    
//                    Text("Instructions")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                    
//                    Text(mealDetail.strInstructions)
//                        .font(.body)
//                        .padding(.bottom)
//                    
//                    Text("Ingredients")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                    
//                    ForEach(mealDetail.ingredientsAndMeasures, id: \.self) { ingredient in
//                        Text(ingredient)
//                            .font(.body)
//                    }
//                    
//                    Spacer()
//                }
//                .padding()
//            } else if mealDetailViewModel.isLoading {
//                ProgressView("Loading...")
//            } else {
//                Text("No recipe available at this time 😞")
//                    .foregroundColor(.secondary)
//            }
//        }
//        .navigationTitle("Meal Details")
//        .navigationBarTitleDisplayMode(.inline)
//        .onAppear {
//            mealDetailViewModel.loadMealDetail(mealID: mealID)
//        }
//    }
//}
import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var mealDetailViewModel = MealDetailViewModel()
    @State private var favorite: Bool = false // To keep track of the favorite state
    
    var body: some View {
        ScrollView {
            if let mealDetail = mealDetailViewModel.mealDetail {
                VStack(alignment: .leading, spacing: 20) {
                    // Meal image
                    AsyncImage(url: mealDetail.strMealThumb) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    
                    // Meal title
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Ingredients list
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(mealDetail.ingredients.indices, id: \.self) { index in
                        if let ingredient = mealDetail.ingredients[index],
                           let measure = mealDetail.measures[index], !ingredient.isEmpty, !measure.isEmpty {
                            HStack {
                                CheckBoxView() // Stateless checkbox
                                Text("\(ingredient) - \(measure)")
                                    .font(.body)
                            }
                        }
                    }
                    
                    // Instructions
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(mealDetail.strInstructions.components(separatedBy: ". "), id: \.self) { step in
                        if !step.trimmingCharacters(in: .whitespaces).isEmpty {
                            HStack {
                                
                                Text(step.trimmingCharacters(in: .whitespacesAndNewlines))
                                    .font(.body)
                            }
                        }
                    }
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
        .navigationBarItems(trailing: favoriteButton)
        .onAppear {
            mealDetailViewModel.loadMealDetail(mealID: mealID)
        }
    }
    
    private var favoriteButton: some View {
        Button(action: {
            self.favorite.toggle()
            // Later, add the logic to save to CoreData
        }) {
            Image(systemName: favorite ? "heart.fill" : "heart")
                .foregroundColor(favorite ? .red : .gray)
        }
    }
}

//  CheckBoxView
struct CheckBoxView: View {
    @State private var isChecked: Bool = false
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .foregroundColor(isChecked ? .green : .gray)
            .onTapGesture {
                self.isChecked.toggle() // Simply toggle the local state
            }
    }
}


// For previews
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        MealDetailView(mealID: "53049")
    }
}



