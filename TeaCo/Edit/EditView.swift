import SwiftUI
import Firebase

let ref = Database.database().reference().child("Hersey").child("Products")

class ProductData: ObservableObject 
{
    
    @Published var selectedProducts: [CustomData] = []
    @Published var deletedItems: [CustomData] = []
    @Published var products: [CustomData] = []
    @Published var addedProducts: [CustomData] = []
    @Published var comboProducts: [CustomData] = []
    @Published var images: [Images] = []
    @Published var id: String = ""
    func updateImage(for id: String, with newImage: UIImage) 
    {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].image = newImage
        } else
        {
            let newImageData = Images(id: id, image: newImage)
            images.append(newImageData)
        }
    }
}

struct EditView: View 
{
    @EnvironmentObject var productData: ProductData
    @StateObject var viewRouter: ViewRouter
    @State var editButton = false

    var body: some View 
    {
        VStack 
        {
            HStack
            {
                Text("< BACK to payment")
                    .font(Font.custom("Inter", size: 25))
                    .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                    .frame(width: 276, height: 38, alignment: .topLeading)
                    .padding(.vertical, 30)
                    .onTapGesture 
                    {
                        viewRouter.currentPage = .cashcred
                    }
                
                Spacer()
                
                if editButton 
                {
                    HStack
                    {
                        Text("add new")
                            .font(Font.custom("Inter", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.25, green: 0.55, blue: 0.24))
                            .frame(width: 149, height: 35, alignment: .top)
                            .onTapGesture 
                            {
                                    addNewProductLocally()
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
                            .onTapGesture 
                            {
                                for product in productData.selectedProducts
                                {
                                    productData.deletedItems.append(product)
                                }
                                deleteProductsInArray()
                                productData.selectedProducts.removeAll()
                            }
                    }
                    .offset(x:-40)
                }

                Spacer()

                if editButton == false 
                {
                    Image("Edit")
                        .frame(width: 53.6429, height: 47.6906)
                        .onTapGesture 
                        {
                            editButton = true
                        }
                        .padding(.vertical, 30)
                        .padding(.trailing, 30)
                } else 
                {
                    VStack (alignment: .trailing) 
                    {
                        Spacer()
                        
                        Text("SAVE")
                            .font(Font.custom("Inter", size: 40).weight(.bold))
                            .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                            .frame(width: 136, height: 38, alignment: .topLeading)
                            .padding(.top, 20)
                            .onTapGesture 
                            {
                                saveDeletedItems()
                                saveAddNewProduct()
                            }
                        
                        Text("CANCEL")
                            .font(Font.custom("Inter", size: 40).weight(.bold))
                            .foregroundColor(Color(red: 1, green: 0.23, blue: 0.19))
                            .frame(width: 192, height: 38, alignment: .topLeading)
                            .padding(.top, 5)
                            .onTapGesture 
                            {
                                editButton = false
                                productData.addedProducts.removeAll()
                                loadData(school: "Hersey") 
                                { loadedProducts in
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

            if editButton == false 
            {
                EditFalse()
            } else
            {
                EditTrue()
            }
        }
    }

    func saveDeletedItems() 
    {
        for item in productData.deletedItems 
        {
            ref.child(item.id).removeValue { error, _ in
                if let error = error 
                {
                } else 
                {
                }
            }
        }
        productData.deletedItems.removeAll()
        editButton = false
    }
    
    func addNewProductLocally() 
    {
        let newProduct = CustomData(id: UUID().uuidString, name: "Name", price: 0.0)
        productData.products.append(newProduct)
    }
    
    func deleteProductsInArray() {
        let idsToDelete = Set(productData.deletedItems.map { $0.id })
        productData.products = productData.products.filter { !idsToDelete.contains($0.id) }
//        productData.deletedItems.removeAll()
    }

    func saveAddNewProduct() 
    {
        for product in productData.products 
        {
            let productRef = ref.child(product.id)
            productRef.observeSingleEvent(of: .value, with: { snapshot in
                if snapshot.exists() 
                {
                    productRef.updateChildValues(["Name": product.name, "Price": product.price])
                } else 
                {
                    productRef.setValue(["Name": product.name, "Price": product.price])
                }
            })
        }
        print(productData.images)
    }

}
