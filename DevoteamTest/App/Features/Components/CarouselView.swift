import SwiftUI

struct CarouselView: View {
    @State var imagesArray: [String]
    
    var body: some View {
        TabView {
            ForEach(imagesArray, id: \.self) { image in
                AsyncImage(url: URL(string: image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.white
                }
                .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    let mockArray = ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"]
    return CarouselView(imagesArray: mockArray)
}
