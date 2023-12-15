import SwiftUI

struct PayView: View {
    @StateObject var viewRouter:ViewRouter
    @State var totalImages:[AnyView] = []
    @State var totalMoney: [Double] = []
    @EnvironmentObject var amountDue: AmountDue
    @EnvironmentObject var changeDue: ChangeDue
    
    func sum() -> Double {
        var tot: Double = 0
        for order in totalMoney {
            tot += order
        }
        return (tot * 100).rounded() / 100
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    VStack{
                        Text("Due: \(String(format: "$%.2f", amountDue.amountDue))")
                            .font(
                                Font.custom("Inter", size: 65)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.99, green: 0.4, blue: 0.1))
                            .frame(alignment: .center)
                            .padding(.top,35)
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 530, maxHeight: .infinity)
                            .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                            .cornerRadius(20)
                        
                            .shadow(color: .black.opacity(0.13), radius: 7, x: 2, y: 6)
                            .shadow(color: .black.opacity(0.11), radius: 13, x: 8, y: 25)
                            .shadow(color: .black.opacity(0.07), radius: 17.5, x: 17, y: 56)
                            .shadow(color: .black.opacity(0.02), radius: 20.5, x: 31, y: 99)
                            .shadow(color: .black.opacity(0), radius: 22.5, x: 48, y: 155)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 2)
                                    .stroke(Color(red: 0.32, green: 0.21, blue: 0.16), lineWidth: 4)
                            )
                            .overlay(
                                ScrollView {
                                    VStack {
                                        ForEach(0..<totalImages.count, id: \.self) { index in
                                            totalImages[index]
                                        }
                                    }
                                }
                                    .padding(.top,20)
                            )
                            .offset(x:-21, y:25)
                    }

                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .foregroundColor(.clear)
                        .background(Color.clear)
                        .overlay(
                            HStack{
                                Spacer()
                                VStack{
                                    Spacer()
                                    Penny()
                                        .onTapGesture {
                                            totalImages.append(AnyView(Penny()))
                                            totalMoney.append(0.01)
                                            
                                            
                                        }

                                    Spacer()
                                        
                                    Nickel()
                                        .onTapGesture {
                                            totalImages.append(AnyView(Nickel()))
                                            totalMoney.append(0.05)
                                        }

                                    Spacer()
                                    Dime()
                                        .onTapGesture {
                                            totalImages.append(AnyView(Dime()))
                                            totalMoney.append(0.1)
                                        }

                                    Spacer()
                                    Quarter()
                                        .onTapGesture {
                                            totalImages.append(AnyView(Quarter()))
                                            totalMoney.append(0.25)
                                        }

                                    Spacer()
                                }
                                Spacer()
                                VStack{
                                    Spacer()
                                    OneDollar()
                                        .onTapGesture {
                                            totalImages.append(AnyView(OneDollar()))
                                            totalMoney.append(1)
                                            
                                        }

                                    Spacer()
                                    FiveDollar()
                                        .onTapGesture {
                                            totalImages.append(AnyView(FiveDollar()))
                                            totalMoney.append(5)
                                        }

                                    Spacer()
                                    TenDollar()
                                        .onTapGesture {
                                            totalImages.append(AnyView(TenDollar()))
                                            totalMoney.append(10)
                                        }

                                    Spacer()
                                    TwentyDollar()
                                        .onTapGesture {
                                            totalImages.append(AnyView(TwentyDollar()))
                                            totalMoney.append(20)
                                        }

                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        )
                }
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 164)
                    .background(Color(red: 0.32, green: 0.21, blue: 0.16))
                    .overlay (
                        HStack{
                            VStack{
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
                                            .offset(y:2)
                                            
                                        
                                    )
                                    .onTapGesture{
                                        totalImages.removeAll()
                                    }
                                
                                Spacer()
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 151, height: 50)
                                    .background(Color(red: 0.99, green: 0.4, blue: 0.1))
                                    .cornerRadius(20)
                                    .overlay(
                                        Text("BACK")
                                            .font(Font.custom("Inter", size: 25))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 151, height: 34, alignment: .center)
                                            .offset(y:2)
                                    )
                                    .onTapGesture {
                                        viewRouter.currentPage = .order
                                    }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 25)
                            
                            Text("Paid: \(String(format: "$%.2f", sum()))")
                                .font(
                                    Font.custom("Inter", size: 65)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                                .frame(width: 447, height: 106, alignment: .leading)
                            
                            Spacer()
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 372, height: 93)
                                .background(.white)
                                .cornerRadius(37.08609)
                                .overlay(
                                    Text("CHANGE")
                                        .font(Font.custom("Inter", size: 50))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.99, green: 0.4, blue: 0.1))
                                        .frame(width: 372, height: 39, alignment: .center)
                                        .offset(y:2)
                                )
                                .padding(.trailing, 50)
                                .onTapGesture {
                                    changeDue.changeDue = sum() - amountDue.amountDue
                                    if changeDue.changeDue == 0 {
                                        viewRouter.currentPage = .cashcred
                                        amountDue.amountDue = 0
                                    } else if changeDue.changeDue > 0 {
                                        viewRouter.currentPage = .change
                                        amountDue.amountDue = 0
                                    }
                                    
                                }
                            
                        }
                    )
            }
        }
        
    }
}
