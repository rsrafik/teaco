import Firebase

class EditViewModel: ObservableObject {
    @Published var products: [CustomData] = []
    @Published var selectedProducts: [CustomData] = []
    @Published var deletedItems: [CustomData] = []

    // Load the products from Firebase
    func loadData(school: String, completion: @escaping ([CustomData]) -> Void) {
        let ref = Database.database().reference().child(school).child("Products")

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var items: [CustomData] = []

            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dictionary = childSnapshot.value as? [String: Any],
                   let name = dictionary["Name"] as? String,
                   let price = dictionary["Price"] as? Double {
                    let dataItem = CustomData(id: childSnapshot.key, name: name , price: price)
                    items.append(dataItem)
                }
            }
            completion(items)
            
        }) { (error) in
            completion([])
        }
    }

    // Remove the product
    func removeProduct(product: CustomData) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            deletedItems.append(products[index])
            products.remove(at: index)
        }
    }

    // Save deleted items to Firebase
    func saveDeletedItems() {
        for item in deletedItems {
            ref.child(item.id).removeValue { error, _ in
                if let error = error {
                    print("Error removing product: \(error)")
                } else {
                    print("Successfully removed product with ID: \(item.id)")
                }
            }
        }
        // Clear the deletedItems after saving them
        deletedItems.removeAll()
    }
    
    // Add a new product to Firebase
    func addNewProduct() {
        // Generate a new child location using a unique key.
        let newProductRef = ref.childByAutoId()

        // Initially set the product's name and price to empty.
        newProductRef.setValue(["Name": "name", "Price": 0]) { error, _ in
            if let error = error {
                print("Error adding new product: \(error)")
            } else {
                print("Successfully added new product.")
            }
        }
    }
}

//struct CustomData: Identifiable {
//    var id: String
//    var name: String
//    var price: Double
//}
