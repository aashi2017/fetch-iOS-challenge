//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.
//
import SwiftUI

struct DessertListView: View {
    @StateObject private var viewModel = DessertListViewModel()
    @State private var showHint = true
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center){
                dessertList
                    .navigationTitle("Desserts")
                    .overlay(loadingOverlay)
                    .alert(isPresented: $viewModel.showError, content: errorAlert)
                    .onAppear(perform: viewModel.fetchDesserts)
                // Hint overlay
                if showHint {
                    HintView(showHint: $showHint) // The custom view for displaying the hint
                }
            }
        }
    }
    
    private var dessertList: some View {
        List {
            ForEach(viewModel.sectionTitles, id: \.self) { letter in
                dessertSection(letter: letter)
            }
        }
    }
    
    private func dessertSection(letter: String) -> some View {
        Section(header: Text(letter)) {
            ForEach(viewModel.dessertsGroupedByFirstLetter[letter] ?? []) { dessert in
                dessertRow(for: dessert)
            }
        }
    }
    
    private func dessertRow(for dessert: Meal) -> some View {
        NavigationLink(destination: MealDetailView(mealID: dessert.idMeal))  {
            DessertRowView(dessert: dessert)
        }
    }
    
    private var loadingOverlay: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            }
        }
    }
    
    private func errorAlert() -> Alert {
        Alert(
            title: Text("Error"),
            message: Text(viewModel.errorMessage),
            dismissButton: .default(Text("OK"))
        )
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
