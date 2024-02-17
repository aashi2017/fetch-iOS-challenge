//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.
// 
import SwiftUI

struct DessertListView: View {
    @StateObject private var viewModel = DessertListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.desserts) { dessert in
                NavigationLink(destination: MealDetailView(meal: viewModel.selectedMealDetail ?? MealDetail.defaultValue)) {
                    DessertRowView(dessert: dessert)
                }
                .onTapGesture {
                    viewModel.selectDessert(with: dessert.idMeal)
                }
            }
            .navigationTitle("Desserts")
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                viewModel.fetchDesserts()
            }
        }
    }
}

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

struct DessertDetailView: View {
    let dessertId: String
    // This view would have its own ViewModel to load the dessert details
    // For simplicity, we're just showing the ID here
    var body: some View {
        Text("Dessert details for ID: \(dessertId)")
    }
}

extension MealDetail {
    static var defaultValue: MealDetail {
        return MealDetail(
            idMeal: "0",
            strMeal: "Placeholder Meal",
            strInstructions: "Sample instructions will be shown here.",
            strMealThumb: URL(string: "https://www.example.com/placeholder.jpg")!,
            ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"],
            measures: ["1 unit", "2 units", "3 units"]
        )
    }
}
