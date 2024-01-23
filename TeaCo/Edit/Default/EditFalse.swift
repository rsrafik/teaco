import SwiftUI

struct EditFalse: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @EnvironmentObject var productData: ProductData
    
    var body: some View 
    {
        VStack
        {
            HStack
            {
                Text("PRODUCTS")
                    .font(
                        Font.custom("Inter", size: 40)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: 288, height: 52, alignment: .topLeading)
                Spacer()
            }
            .padding(.leading,35)
            
            ScrollView 
            {
                LazyVGrid(columns: columns, spacing: 20) 
                {
                    ForEach(productData.products) 
                    { product in
                        Item(data: product)
                            .onAppear(
                            )
                    }
                }
            }
            .offset(y:14)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
