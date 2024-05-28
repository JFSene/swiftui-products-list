# SwiftUI Async/Await Networking with SwiftData

This project demonstrates how to perform network requests using async/await in SwiftUI, along with data persistence using SwiftData.

## Overview

The project consists of the following components:

1. **Networking Service**: The `NetworkService` class is responsible for making asynchronous network requests to fetch product data from a remote API. It uses the async/await syntax introduced in Swift 5.5 for asynchronous programming.

2. **Model**: The project includes models (`Product) representing the structure of product data fetched from the API. These models conform to the `Codable` protocol for easy serialization and deserialization of JSON data.

3. **ViewModel**: The `ProductsListViewModel` class serves as the view model for the product listing view. It interacts with the networking service to fetch product data and provides the necessary data for the view to render.

4. **SwiftData for Data Persistence**: SwiftData is used for local data persistence. It provides a convenient way to store and manage model objects locally on the device.

## Async/Await Networking

The `NetworkService` class utilizes async/await to perform network requests asynchronously. This allows for cleaner and more readable code compared to traditional completion handler-based approaches.

```swift
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
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Product].self, from: data)
        } catch {
            throw CustomError.invalidData
        }
    }
}
```
## SwiftData for Data Persistence

SwiftData is used for local data persistence, allowing the app to store product data locally on the device. This enables offline access to product information and improves app performance by reducing reliance on network requests.

```swift
import SwiftData

class ProductsListViewModel: ObservableObject {
    // Other code...
    
    func fetchProductsList() async {
        isLoading = true
        
        do {
            let productsList = try await NetworkService.shared.getProductsList()
            self.products = productsList
            productsList.forEach { self.modelContext?.insert($0) } // Insert fetched products into local database
            isLoading = false
        } catch {
            errorMessage = "An unexpected error occurred"
            showAlert = true
            isLoading = false
        }
    }
}
```
## Requirements

- Xcode 13+
- Swift 5.5+
- iOS 15+

## Installation

Clone the repository and open the Xcode project file. Build and run the project on a simulator or device running iOS 15 or later.

```bash
git clone https://github.com/your-username/your-project.git
``` 
## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
