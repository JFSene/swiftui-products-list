import Foundation
import Combine

final class NetworkService {
    static let shared = NetworkService()
    private let urlSrting = "https://dummyjson.com/products"
    
    func getProductsList() async throws -> [Product] {
        guard let url = URL(string: urlSrting) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        // Print raw JSON response for debugging
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON response: \(jsonString)")
        }
        
        do {
            let decoder = JSONDecoder()
            let productsResponse = try decoder.decode(ProductsResponse.self, from: data)
            return productsResponse.products
        } catch {
            print("Decoding error: \(error)")
            throw CustomError.invalidData
        }
    }
}
