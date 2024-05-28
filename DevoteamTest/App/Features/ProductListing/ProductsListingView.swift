import SwiftUI
import SwiftData

struct ProductsListingView: View {
    // ViewModel for managing product data and state
    @EnvironmentObject var viewModel: ProductsListViewModel
    // Query to fetch products sorted by rating in reverse order
    @Query(sort: [SortDescriptor(\Product.rating, order: .reverse)]) var productsListModel: [Product]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Color.white.ignoresSafeArea()
                LazyVStack(spacing: 8) {
                    ForEach(productsListModel, id: \.self) { product in
                        NavigationLink(value: product) {
                            ProductListingItem(product: product)
                        }
                    }
                }
                .overlay {
                    if viewModel.isLoading {
                        LoaderView()
                            .frame(alignment: .center)
                            .padding(.top, 350)
                    }
                }
            }
            // Task to fetch products if the list is empty
            .task {
                if productsListModel.isEmpty {
                    await viewModel.fetchProductsList()
                }
            }
            // Display alert if an error occurs during data fetching
            .alert(isPresented: $viewModel.showAlert) {
                return Alert(
                    title: Text("Oops, somthing went wrong"),
                    message: Text(viewModel.errorMessage ?? "")
                )
            }
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
                    .navigationBarBackButtonHidden()
            }
            .navigationTitle("Products List")
        }
    }
}

#Preview {
    ProductsListingView()
}
