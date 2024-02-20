//
//  MealDetailViewModel.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/16/24.
//
//The class is responsible for fetching and storing the details of a specific meal from a meal service.
import Foundation
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    private var mealService = MealService()

    func loadMealDetail(mealID: String) {
        isLoading = true
        mealService.fetchMealDetails(by: mealID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealDetailList):
                    self?.mealDetail = mealDetailList.meals.first
                case .failure:
                    self?.mealDetail = nil
                }
            }
        }
    }
}
