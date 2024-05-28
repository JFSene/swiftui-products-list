import SwiftUI

struct ProductDetailView: View {
    @State var product: Product
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                CarouselView(imagesArray: product.images ?? [])
                    .frame(height: 320)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width: 40, height: 40)
                        }
                        .padding(32)
                }
            }
            .padding()
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Price: \(product.price, specifier: "%.2f") €")
                        .fontWeight(.semibold)
                    Text("Discount: \(product.discountPercentage, specifier: "%.2f")%")
                        .font(.subheadline)
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(product.rating, specifier: "%.2f")")
                        Text("In Stock: \(product.stock)")
                            .padding(.leading, 200)
                            .font(.footnote)
                    }
                    .foregroundStyle(.black)
                }
                
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            
            // listing features
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    VStack(alignment: .leading) {
                        Text("Description:")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(product.productDescription)
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
            .padding()
            Divider()
        }
        .ignoresSafeArea()
        .padding(.bottom, 20)
    }
}
