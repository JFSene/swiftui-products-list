import Foundation
import Combine
import SwiftData

@MainActor
final class ProductsListViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var products: [Product] = []
    
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    func fetchProductsList() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let productsList = try await NetworkService.shared.getProductsList()
            self.products = productsList
            productsList.forEach { self.modelContext?.insert($0) }
            isLoading = false
        } catch let error as CustomError {
            errorMessage = error.localizedDescription
            showAlert = true
            isLoading = false
        } catch {
            errorMessage = "An unexpected error occurred"
            showAlert = true
            isLoading = false
        }
    }
}
