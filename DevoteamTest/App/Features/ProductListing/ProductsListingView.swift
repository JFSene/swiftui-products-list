import SwiftUI
import SwiftData

struct ProductsListingView: View {
    @EnvironmentObject var viewModel: ProductsListViewModel
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
            .task {
                if productsListModel.isEmpty {
                    await viewModel.fetchProductsList()
                }
            }
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
