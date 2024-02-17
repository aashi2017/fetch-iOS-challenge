import Foundation

class MealService {
    private let baseUrl = "https://www.themealdb.com/api/json/v1/1"
    
    // Fetch the list of meals in the Dessert category
    func fetchDesserts(completion: @escaping (Result<MealList, Error>) -> Void) {
        let dessertsUrl = "\(baseUrl)/filter.php?c=Dessert"
        
        guard let url = URL(string: dessertsUrl) else {
//            print("Invalid URL: \(dessertsUrl)")
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        print("Fetching desserts from URL: \(url.absoluteString)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
//                print("Error fetching desserts: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
//                print("No data received for desserts")
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let mealList = try JSONDecoder().decode(MealList.self, from: data)
               // print("Successfully fetched desserts: \(mealList)")
                completion(.success(mealList))
            } catch {
                //print("Error decoding desserts: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Fetch the meal details by its ID
    func fetchMealDetails(by id: String, completion: @escaping (Result<MealDetailList, Error>) -> Void) {
        let mealDetailUrl = "\(baseUrl)/lookup.php?i=\(id)"
        
        guard let url = URL(string: mealDetailUrl) else {
            print("Invalid URL: \(mealDetailUrl)")
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        print("Fetching meal details from URL: \(url.absoluteString)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching meal details: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
//                print("No data received for meal details")
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let mealDetailList = try JSONDecoder().decode(MealDetailList.self, from: data)
//                print("Successfully fetched meal details: \(mealDetailList)")
                completion(.success(mealDetailList))
            } catch {
//                print("Error decoding meal details: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidUrl
    case noData
}

