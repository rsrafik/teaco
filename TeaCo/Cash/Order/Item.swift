import SwiftUI

struct Item: View {
    
    @EnvironmentObject var productData: ProductData
    var data: CustomData
    
    var body: some View 
    {
        VStack
        {
            Group {
               if let initialImage = productData.images.first(where: { $0.id == data.id })?.image {
                                Image(uiImage: initialImage)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .overlay(
                                        Image("NoImage")
                                            .frame(width: 100, height: 100)
                                    )
                            }
                        }
            .foregroundColor(.clear)
            .frame(width: 199, height: 273)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            .cornerRadius(20)
            
            ZStack 
            {
                VStack 
                {
                    HStack 
                    {
                        Text(data.name)
                            .font(Font.custom("Inter", size: 25))
                            .foregroundColor(.black)
                            .frame(alignment: .topLeading)
                        
                        Spacer()
                        
                    }
                    
                    HStack
                    {
                        Text("$\(String(format: "%.2f", data.price))")
                            .font(Font.custom("Inter", size: 25))
                            .foregroundColor(.black)
                            .frame(alignment: .topLeading)
                        
                        Spacer()
                        
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(width: 199)
        }
    }
}

