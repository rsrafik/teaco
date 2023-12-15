import SwiftUI
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TeaCoApp: App {
    @StateObject var viewRouter = ViewRouter()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var productData = ProductData() 
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .environmentObject(productData)
        }
    }
}

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

//func loadImages(school: String, products: [CustomData], completion: @escaping ([Images]) -> Void) {
//    var images: [Images] = []
//
//    let group = DispatchGroup()
//
//    for product in products {
//        group.enter()
//        let storageRef = Storage.storage().reference().child("\(school)/Images/\(product.id)")
//        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            defer { group.leave() }
//
//            if let error = error {
//                print("Error loading image for \(product.id): \(error.localizedDescription)")
//            } else if let data = data, let image = UIImage(data: data) {
//                let imageObj = Images(id: product.id, image: image)
//                images.append(imageObj)
//            }
//        }
//    }
//
//    group.notify(queue: .main) {
//        completion(images)
//    }
//}


class CustomData: ObservableObject, Identifiable {
    let id: String
    @Published var name: String
    @Published var price: Double

    init(id: String, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
}

class Images: ObservableObject, Identifiable {
    let id: String
    @Published var image: UIImage

    init(id: String, image:UIImage) {
        self.id = id
        self.image = image
    }
    
    
}

