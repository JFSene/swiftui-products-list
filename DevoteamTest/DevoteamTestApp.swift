//
//  DevoteamTestApp.swift
//  DevoteamTest
//
//  Created by Joel Sene on 25/05/2024.
//

import SwiftUI
import SwiftData

@main
struct DevoteamTestApp: App {
    // Create a ModelContainer to manage the data of type Product
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ProductsListingView()
            // Provide the ProductsListViewModel to the ProductsListingView as an environment object
                .environmentObject(ProductsListViewModel(modelContext: container.mainContext))
            // Set the model container for the entire app
                .modelContainer(container)
        }
    }
    
    
    init() {
        do {
            // Create a ModelContainer for managing data of type Product
            container = try ModelContainer(for: Product.self)
        } catch {
            fatalError("Failed to create ModelContainer for Products")
        }
    }
    
}
