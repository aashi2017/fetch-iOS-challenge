//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.
//The class provides functionality to fetch dessert data from a service, handle the result, and manage the data for display, such as grouping desserts by their first letter and sorting section titles.
import Combine
import Foundation
class DessertListViewModel: ObservableObject {
    @Published var desserts: [Meal] = []
    @Published var isLoading = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var selectedMealDetail: MealDetail?
    @Published var searchText = "" // Holds the search text
    @Published var filteredDesserts: [Meal] = []
    
    private var mealService = MealService()
    private var cancellables = Set<AnyCancellable>()
    
      init() {
          // Combine setup to update filteredDesserts based on searchText
          $searchText
              .receive(on: RunLoop.main)
              .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
              .removeDuplicates()
              .map { [unowned self] searchText in
                  if searchText.isEmpty {
                      return self.desserts
                  } else {
                      return self.desserts.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
                  }
              }
              .assign(to: \.filteredDesserts, on: self)
              .store(in: &cancellables)
      }
    
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
    // Group desserts by the first letter of their name
    var dessertsGroupedByFirstLetter: [String: [Meal]] {
        Dictionary(grouping: desserts, by: { String($0.strMeal.prefix(1)) })
    }
    
    var sectionTitles: [String] {
        let relevantDesserts = searchText.isEmpty ? desserts : filteredDesserts
        let groupedDesserts = Dictionary(grouping: relevantDesserts, by: { String($0.strMeal.prefix(1)) })
        return groupedDesserts.filter { !$0.value.isEmpty }.keys.sorted()
    }
    
    func searchResults(for letter: String) -> [Meal] {
        if searchText.isEmpty {
            return dessertsGroupedByFirstLetter[letter] ?? []
        } else {
            return (dessertsGroupedByFirstLetter[letter] ?? []).filter {
                $0.strMeal.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
