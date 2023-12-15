import SwiftUI

class AmountDue: ObservableObject 
{
    @Published var amountDue: Double = 0
}

class ChangeDue: ObservableObject 
{
    @Published var changeDue: Double = 0
}

struct ContentView: View 
{
    @StateObject var viewRouter: ViewRouter
    @StateObject var amountDue = AmountDue()
    @StateObject var changeDue = ChangeDue()
    
    var body: some View 
    {
        switch viewRouter.currentPage
        {
        case .login:
            LoginView(viewRouter: viewRouter)
        case .cashcred:
            CashCredView(viewRouter: viewRouter)
        case .order:
            OrderView(viewRouter: viewRouter)
                .environmentObject(amountDue)
        case .pay:
            PayView(viewRouter: viewRouter)
                .environmentObject(amountDue)
                .environmentObject(changeDue)
        case .change:
            ChangeView(viewRouter: viewRouter)
                .environmentObject(changeDue)
        case .edit:
            EditView(viewRouter:viewRouter)
        }
    }
}
