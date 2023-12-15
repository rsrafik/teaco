import SwiftUI
import Firebase


struct EditTrue: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @EnvironmentObject var productData: ProductData
//    @State var products: [CustomData]
//    @State var deletedItems: [CustomData]
//    @State var selectedProducts: [CustomData]

    var body: some View {
        VStack {
            HStack {
                Text("PRODUCTS")
                    .font(Font.custom("Inter", size: 40).weight(.bold))
                    .foregroundColor(.black)
                    .frame(alignment: .topLeading)
                Spacer()
            }
            .padding(.leading,35)
            .zIndex(3)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach($productData.products, id: \.id) { $product in
                        ItemEdit(data: $product, onDelete: {
                            self.removeProduct(product: product)
                        })
                    }
                }
            }
            .offset(y: -25)
            .onAppear {
                // Assuming you have a predefined school name
                loadData(school: "Hersey") { loadedProducts in
                    productData.products = loadedProducts
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .offset(y:-5)
    }

    func removeProduct(product: CustomData) {
        if let index = productData.products.firstIndex(where: { $0.id == product.id }) {
            productData.deletedItems.append(productData.products[index])
            productData.products.remove(at: index)
        }
    }
    
    
    
}
