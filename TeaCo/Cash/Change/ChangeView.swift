import SwiftUI

struct ChangeView: View {
    
    @EnvironmentObject var productData: ProductData
    @StateObject var viewRouter:ViewRouter
    @EnvironmentObject var changeDue: ChangeDue
    @State var seriesImage: [AnyView] = []
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View
    {
        VStack
        {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: 164)
                .background(hexStringToColor(productData.mainColor))
                .overlay(
                    Text("Return: \(String(format: "$%.2f", changeDue.changeDue))")
                        .font(
                            Font.custom("Inter", size: 65)
                                .weight(.bold)
                        )
                        .foregroundColor(.white)
                        .frame(width: 447, height: 106, alignment: .leading)
                )
            
            ZStack
            {
                ScrollView
                {
                    LazyVGrid(columns: columns, spacing: 20)
                    {
                        ForEach(0..<seriesImage.count, id: \.self)
                        { index in
                            seriesImage[index]
                        }
                    }
                    .padding(.top,20)
                }
                
                VStack
                {
                    Spacer()
                    
                    HStack
                    {
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 372, height: 93)
                            .background(hexStringToColor(productData.subColor))
                            .cornerRadius(37.08609)
                            .shadow(color: .black.opacity(0.13), radius: 2, x: -1, y: 1)
                            .shadow(color: .black.opacity(0.11), radius: 3, x: -3, y: 5)
                            .shadow(color: .black.opacity(0.07), radius: 4.5, x: -8, y: 12)
                            .shadow(color: .black.opacity(0.02), radius: 5, x: -14, y: 22)
                            .shadow(color: .black.opacity(0), radius: 5.5, x: -22, y: 34)
                            .overlay(
                                Text("NEW ORDER")
                                    .font(Font.custom("Inter", size: 50))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 372, height: 39, alignment: .center)
                            )
                            .padding(.trailing,50)
                            .padding(.bottom,50)
                            .onTapGesture
                        {
                            viewRouter.currentPage = .cashcred
                        }
                    }
                }
            }
        }
        .onAppear
        {
            iterate(i: changeDue.changeDue)
        }
    }
    
    func iterate(i: Double)
    {
        var z = i
        
        if z >= 0
        {
            while z >= 0.005
            {
                while (z >= 20)
                {
                    z-=20
                    seriesImage.append(AnyView(TwentyDollar()))
                }
                while (z >= 10 && z < 20)
                {
                    z -= 10
                    seriesImage.append(AnyView(TenDollar()))
                }
                while (z >= 5 && z < 10)
                {
                    z -= 5
                    seriesImage.append(AnyView(FiveDollar()))
                }
                while (z >= 1 && z < 5)
                {
                    z -= 1
                    seriesImage.append(AnyView(OneDollar()))
                }
                while (z >= 0.25 && z < 1)
                {
                    z -= 0.25
                    seriesImage.append(AnyView(Quarter()))
                }
                while (z >= 0.09 && z < 0.25)
                {
                    z -= 0.10
                    seriesImage.append(AnyView(Dime()))
                    
                }
                while (z >= 0.05 && z < 0.09)
                {
                    z -= 0.05
                    seriesImage.append(AnyView(Nickel()))
                }
                while (z >= 0.005 && z < 0.05)
                {
                    z -= 0.01
                    seriesImage.append(AnyView(Penny()))
                }
            }
        }
    }
}


