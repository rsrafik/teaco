import SwiftUI

struct OrderView: View {
    @StateObject var viewRouter:ViewRouter
    @State private var products: [CustomData] = []
    @State var owed: [Order] = []
    @State var total:Double = 0
    @EnvironmentObject var amountDue: AmountDue
    
    func sumOrder() -> Double 
    {
        var tot: Double = 0
        for order in owed 
        {
            tot += order.price
        }
        return tot
    }

    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View 
    {
        VStack 
        {
            HStack 
            {
                Text("< BACK to payment")
                    .onTapGesture 
                    {
                        viewRouter.currentPage = .cashcred
                    }
                    .font(Font.custom("Inter", size: 25))
                    .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                    .frame(width: 276, height: 38, alignment: .topLeading)
                    
                
                Spacer()
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 151, height: 50)
                    .background(Color(red: 0.99, green: 0.4, blue: 0.1))
                    .cornerRadius(20)
                    .overlay(
                        Text("CLEAR")
                            .font(Font.custom("Inter", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 151, height: 34, alignment: .center)
                            .padding(.top, 5)
                            .onTapGesture 
                            {
                                owed.removeAll()
                            }
                    )
            }
            .padding(.leading, 25)
            .padding(.trailing, 50)
            .padding(.vertical, 25)
            
            
            HStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        ScrollView 
                        {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(products) 
                                { product in
                                    Item(data: product)
                                        .onTapGesture 
                                        {
                                            owed.append(Order(id: product.name, price: product.price))
                                            
                                        }
                                        
                                }
                            }
                            .padding()
                        }
                        .onAppear 
                            {
                            loadData(school: "Hersey") { loadedProducts in
                                self.products = loadedProducts
                            }
                        }
                    )
                
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: 372, maxHeight: .infinity)
                    .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.18), radius: 2, x: 0, y: 2)
                    .shadow(color: .black.opacity(0.15), radius: 3.5, x: -2, y: 6)
                    .shadow(color: .black.opacity(0.09), radius: 4.5, x: -4, y: 15)
                    .shadow(color: .black.opacity(0.03), radius: 5.5, x: -7, y: 26)
                    .shadow(color: .black.opacity(0), radius: 6, x: -10, y: 40)
                    .overlay(
                        ScrollView 
                        {
                            VStack 
                            {
                                ForEach(0..<owed.count, id: \.self) { index in
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 300, height: 50)
                                        .foregroundColor(Color(red: 0.32, green: 0.21, blue: 0.16))
                                        .overlay(
                                            Text(owed[index].id)
                                                .font(.title)
                                                .padding()
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                        }
                            .padding(.top,20)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 2)
                            .stroke(Color(red: 0.32, green: 0.21, blue: 0.16), lineWidth: 4)
                            
                    )
                    .padding(.trailing, 50)
                    .padding(.bottom, 30)
            }
            
            Spacer()
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: 164)
                .background(Color(red: 0.32, green: 0.21, blue: 0.16))
                .overlay 
                {
                    HStack
                    {
                        Image("Huskie")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 114, height: 126.2000961303711)
                            .clipped()
                            .padding(.horizontal, 40)
                        
                        Text("Due: \(String(format: "$%.2f", sumOrder()))")
                            .font(
                                Font.custom("Inter", size: 65)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                            .frame(alignment: .leading)
                        
                        Spacer()
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 372, height: 93)
                            .background(.white)
                            .cornerRadius(37.08609)
                            .overlay(
                                Text("CHECKOUT")
                                    .font(Font.custom("Inter", size: 50))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.99, green: 0.4, blue: 0.1))
                                    .frame(width: 372, height: 39, alignment: .center)
                                    .padding(.top, 7)
                            )
                            .padding(.trailing, 50)
                            .onTapGesture {
                                amountDue.amountDue = sumOrder()
                                viewRouter.currentPage = .pay
                            }
                    }
                }
        }
    }
}

struct Order: Identifiable 
{
    var id: String
    var price: Double
}



