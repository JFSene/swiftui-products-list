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
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ProductsListingView()
                .environmentObject(ProductsListViewModel(modelContext: container.mainContext))
                .modelContainer(container)
        }
    }
    
    
    init() {
        do {
            container = try ModelContainer(for: Product.self)
        } catch {
            fatalError("Failed to create ModelContainer for Products")
        }
    }
    
}
