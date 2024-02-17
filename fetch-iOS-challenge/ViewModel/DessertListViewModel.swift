//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.
//
import Combine
import Foundation
class DessertListViewModel: ObservableObject {
    @Published var desserts: [Meal] = []
    @Published var isLoading = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var selectedMealDetail: MealDetail?
    
    private var mealService = MealService()
    private var cancellables = Set<AnyCancellable>()
    
    // Function to load desserts
    func fetchDesserts() {
        mealService.fetchDesserts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealList):
                    self?.desserts = mealList.meals.sorted { $0.strMeal < $1.strMeal }
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    //Meal Detail
    func selectDessert(with id: String) {
        self.selectedMealDetail = nil // Clear previous detail
        mealService.fetchMealDetails(by: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let mealDetailList):
                    self?.selectedMealDetail = mealDetailList.meals.first
                case .failure:
                    // Handle the error, you could also set an error message here to display
                    self?.selectedMealDetail = nil
                }
            }
        }
    }
}
