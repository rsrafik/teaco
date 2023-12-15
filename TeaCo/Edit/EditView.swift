import SwiftUI
import Firebase

let ref = Database.database().reference().child("Hersey").child("Products")

class ProductData: ObservableObject {
    @Published var selectedProducts: [CustomData] = []
    @Published var deletedItems: [CustomData] = []
    @Published var products: [CustomData] = []
    @Published var addedProducts: [CustomData] = []
    @Published var comboProducts: [CustomData] = []
    @Published var images: [Images] = []
    
    func updateImage(for id: String, with newImage: UIImage) {
            if let index = images.firstIndex(where: { $0.id == id }) {
                // Update existing image
                images[index].image = newImage
            } else {
                // Add new image
                let newImageData = Images(id: id, image: newImage)
                images.append(newImageData)
            }
        }
}

struct EditView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var productData: ProductData
    @State var editButton = false

    var body: some View {
        VStack {
            HStack{
                Text("< BACK to payment")
                    .font(Font.custom("Inter", size: 25))
                    .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                    .frame(width: 276, height: 38, alignment: .topLeading)
                    .padding(.vertical, 30)
                    .onTapGesture {
                        viewRouter.currentPage = .cashcred
                    }
                
                Spacer()
                
                if editButton {
                    HStack{
                        Text("add new")
                            .font(Font.custom("Inter", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.25, green: 0.55, blue: 0.24))
                            .frame(width: 149, height: 35, alignment: .top)
                            .onTapGesture {
                                    addNewProductLocally()
//                                    combo()
                                }
                        
                        Text("select all")
                            .font(Font.custom("Inter", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                            .frame(width: 136, height: 35, alignment: .top)
                        
                        Text("delete")
                            .font(Font.custom("Inter", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 1, green: 0.23, blue: 0.19))
                            .frame(width: 101, height: 35, alignment: .top)
                            .onTapGesture {
                                for product in productData.selectedProducts {
                                    productData.deletedItems.append(product)
                                    }
                                deleteProductsInArray()
                                productData.selectedProducts.removeAll() // Clear the selectedProducts after adding them to deletedItems
                                }
                        
                        
                    }
                    .offset(x:-40)
                }

                Spacer()

                if editButton == false {
                    Image("Edit")
                        .frame(width: 53.6429, height: 47.6906)
                        .onTapGesture {
                            editButton = true
                        }
                        .padding(.vertical, 30)
                        .padding(.trailing, 30)
                } else {
                    VStack (alignment: .trailing) {
                        Spacer()
                        
                        Text("SAVE")
                            .font(Font.custom("Inter", size: 40).weight(.bold))
                            .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                            .frame(width: 136, height: 38, alignment: .topLeading)
                            .padding(.top, 20)
                            .onTapGesture {
                                saveDeletedItems()
                                saveAddNewProduct()
                                
                            
                            }
                        
                        Text("CANCEL")
                            .font(Font.custom("Inter", size: 40).weight(.bold))
                            .foregroundColor(Color(red: 1, green: 0.23, blue: 0.19))
                            .frame(width: 192, height: 38, alignment: .topLeading)
                            .padding(.top, 5)
                            .onTapGesture {
                                editButton = false
                                productData.addedProducts.removeAll()
                                loadData(school: "Hersey") { loadedProducts in
                                                    productData.products = loadedProducts
                                                }
                            }
                    }
                    .offset(y:15)
                    .frame(maxHeight: .infinity)
                }
            }
            .frame(height: 47.6906)
            .padding(.leading, 30)
            .padding(.vertical, 25)

            if editButton == false {
                            EditFalse()  // Assuming EditFalse does not need to modify products
                        } else {
                            EditTrue()
                        }
        }
    }

    func saveDeletedItems() {
        for item in productData.deletedItems {
            ref.child(item.id).removeValue { error, _ in
                if let error = error {
//                    print("Error removing product: \(error)")
                } else {
//                    print("Successfully removed product with ID: \(item.id)")
                }
            }
        }
        // Clear the deletedItems after saving them
        productData.deletedItems.removeAll()
        editButton = false   // This line will switch back to the default view
    }
    
//    func saveAddNewProduct() {
//        // First, retrieve existing product IDs from Firebase
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            var existingIDs = Set<String>()
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot {
//                    existingIDs.insert(childSnapshot.key)
//                }
//            }
//
//            // Now, check each product in 'addedProducts'
//            for product in productData.products {
//                if !existingIDs.contains(product.id) {
//                    let newProductRef = ref.child(product.id)
//                    newProductRef.setValue(["Name": product.name, "Price": product.price]) { error, _ in
//                        if let error = error {
//                            print("Error adding new product: \(error)")
//                        } else {
//                            print("Successfully added new product with ID: \(product.id)")
//                        }
//                    }
//                }
//            }
//            // Clear the addedProducts after saving them
//            loadData(school: "Hersey") { loadedProducts in
//                                productData.products = loadedProducts
//                            }
//
//        }) { error in
//            print("Error fetching existing product IDs: \(error)")
//        }
//    }


    
    func addNewProductLocally() {
        let newProduct = CustomData(id: UUID().uuidString, name: "Name", price: 0.0)
        productData.products.append(newProduct)

        
    }
    
    func deleteProductsInArray() {
        // Get the IDs of the products to be deleted
        let idsToDelete = Set(productData.deletedItems.map { $0.id })

        // Filter out the products that need to be deleted
        productData.products = productData.products.filter { !idsToDelete.contains($0.id) }

        // After processing, clear the deletedItems
//        productData.deletedItems.removeAll()
    }

//    func combo() {
//        loadData(school: "Hersey") { loadedProducts in
//            productData.products = loadedProducts
//        }
//        productData.comboProducts = productData.products
//        for prod in productData.addedProducts {
//            productData.comboProducts.append(prod)
//        }
//    }
    func saveAddNewProduct() {
        print(productData.$images)
        // Iterate over all products
        print(productData.images)
        for product in productData.products {
            let productRef = ref.child(product.id)
            productRef.observeSingleEvent(of: .value, with: { snapshot in
                if snapshot.exists() {
                    // Product exists, update its details
                    productRef.updateChildValues(["Name": product.name, "Price": product.price]) { error, _ in
                        if let error = error {
//                            print("Error updating product: \(error)")
                        } else {
//                            print("Successfully updated product with ID: \(product.id)")
                        }
                    }
                } else {
                    // Product does not exist, add as a new product
                    productRef.setValue(["Name": product.name, "Price": product.price]) { error, _ in
                        if let error = error {
//                            print("Error adding new product: \(error)")
                        } else {
//                            print("Successfully added new product with ID: \(product.id)")
                        }
                    }
                }
            }) { error in
                print("Error fetching product details: \(error)")
            }
        }
        // Optionally, you may want to reload the products from Firebase after updating
        // loadData(school: "Hersey") { loadedProducts in
        //     productData.products = loadedProducts
        // }
    }

}
