import SwiftUI
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import Combine
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate 
{
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool 
    {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TeaCoApp: App 
{
    @StateObject var viewRouter = ViewRouter()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var productData = ProductData() 
    
    var body: some Scene 
    {
        WindowGroup 
        {
            ContentView(viewRouter: viewRouter)
                .environmentObject(productData)
        }
    }
}
