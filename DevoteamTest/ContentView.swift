//
//  ContentView.swift
//  DevoteamTest
//
//  Created by Joel Sene on 25/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = ProductsListViewModel()
    
    var body: some View {
        ProductsListingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
