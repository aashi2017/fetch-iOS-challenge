//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.
//

import Foundation

import Foundation

// Model for the list of meals in the Dessert category
struct MealList: Codable {
    let meals: [Meal]
}

// Model for an individual meal
struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
    
    var id: String { idMeal } // Conforming to Identifiable
}

