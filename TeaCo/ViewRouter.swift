import SwiftUI

class ViewRouter: ObservableObject
{
    @Published var currentPage:Page = .login
}

enum Page 
{
    case login
    case cashcred
    case order
    case pay
    case change
    case edit
}
