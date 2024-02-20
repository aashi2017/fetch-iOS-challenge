//
//  Meal.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/14/24.

// This is a model and it represents detailed information about a meal, including its ID, name, cooking instructions, image URL, ingredients, and measurements.

import Foundation

struct MealDetailList: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: URL
    let ingredients: [String?]
    let measures: [String?]
    
    var id: String { idMeal }
    init(idMeal: String, strMeal: String, strInstructions: String, strMealThumb: URL, ingredients: [String?], measures: [String?]) {
          self.idMeal = idMeal
          self.strMeal = strMeal
          self.strInstructions = strInstructions
          self.strMealThumb = strMealThumb
          self.ingredients = ingredients
          self.measures = measures
      }

    // Computed property to combine ingredients and measures
    var ingredientsAndMeasures: [String] {
        zip(ingredients, measures)
            .compactMap { ingredient, measure in
                guard let ingredient = ingredient, !ingredient.isEmpty,
                      let measure = measure, !measure.isEmpty else { return nil }
                return "\(ingredient): \(measure)"
            }
    }
    
    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
             strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
             strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
             strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
             strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
        
        let allKeys = container.allKeys
        ingredients = (1...20).compactMap { index in
            let key = CodingKeys(rawValue: "strIngredient\(index)")!
            return allKeys.contains(key) ? try? container.decodeIfPresent(String.self, forKey: key) : nil
        }
        
        measures = (1...20).compactMap { index in
            let key = CodingKeys(rawValue: "strMeasure\(index)")!
            return allKeys.contains(key) ? try? container.decodeIfPresent(String.self, forKey: key) : nil
        }
    }
}

