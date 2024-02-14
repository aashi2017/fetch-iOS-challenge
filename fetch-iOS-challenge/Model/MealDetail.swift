//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.
//
// Model for the details of a meal

import Foundation
struct MealDetailList: Codable {
    let meals: [MealDetail]
}

// Model for the details of an individual meal
struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: URL
    let strIngredients: [String?]
    let strMeasures: [String?]
    
    // Computed property to combine ingredients and measures
    var ingredientsAndMeasures: [String] {
        Array(zip(strIngredients, strMeasures))
            .filter { !$0.0!.isEmpty && !$0.1!.isEmpty }
            .map { "\($0.0!) - \($0.1!)" }
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
        
        // Decoding ingredients and measures
        strIngredients = (1...20).compactMap {
            try? container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strIngredient\($0)")!)
        }
        strMeasures = (1...20).compactMap {
            try? container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strMeasure\($0)")!)
        }
    }
}

