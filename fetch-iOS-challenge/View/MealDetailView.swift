//
//  SwiftUIView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/16/24.
//
//This View provides a detailed view of a selected meal, including its image, title, ingredients, and preparation instructions. It utilizes a MealDetailViewModel to fetch and store meal details. 
import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var mealDetailViewModel = MealDetailViewModel()
    @State private var favorite: Bool = false
    @State private var showHint: Bool = false
    
    var body: some View {
        ZStack {
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
                        .cornerRadius(10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
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
                // Delay the hint display by 5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        showHint = true
                    }
                }
            }
            // HintView overlay
            if showHint {
                HintView(showHint: $showHint, title: "Did you know?", subtitle: "🤤♥️", description: "You can mark a dessert as a favorite by tapping the heart icon on the right top corner.")
                    .transition(.opacity) 
            }
            
        }
        
        
    }
    
    private var favoriteButton: some View {
        Button(action: {
            self.favorite.toggle()
            // FUTURE :  add the logic to save to CoreData
        }) {
            Image(systemName: favorite ? "heart.fill" : "heart")
                .foregroundColor(favorite ? .red : .gray)
        }
    }
}






#Preview {
    MealDetailView(mealID: "53049")
}


