import SwiftUI

struct CashCredView: View {
    @StateObject var viewRouter:ViewRouter
    
    @State var passwordShare = false
    @State var passwordEdit = false
    @State private var isPasswordVisible: Bool = false
    @State var animate = false
    let password = "1234"
    @EnvironmentObject var productData: ProductData
    
    @State private var text: String = ""
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: nil) {
                HStack{
                    Image("Share")
                        .onTapGesture {
                            passwordShare.toggle()
                            withAnimation (.easeInOut(duration: 0.3) ){
                                animate.toggle()
                            }
                            
                        }
                    Spacer()
                    Text("Edit")
                        .font(Font.custom("Inter", size: 40))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                        .frame(width: 119, height: 59, alignment: .top)
                        .padding(.top,20)
                        .onTapGesture {
                            passwordEdit.toggle()
                            withAnimation (.easeInOut(duration: 0.3) ){
                                animate.toggle()
                            }
                        }
                }
                .frame(height: 59)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
                
                Spacer() // This will push the next HStack to the center
                
                HStack {
                    Spacer() // Spacer on the left side
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 422, height: 230)
                        .background(Color(red: 0.18, green: 0.31, blue: 0.19))
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.13), radius: 0, x: 0, y: 0)
                        .shadow(color: .black.opacity(0.13), radius: 4.5, x: -1, y: 4)
                        .shadow(color: .black.opacity(0.11), radius: 8.5, x: -4, y: 16)
                        .shadow(color: .black.opacity(0.07), radius: 11, x: -8, y: 36)
                        .shadow(color: .black.opacity(0.02), radius: 13, x: -14, y: 65)
                        .shadow(color: .black.opacity(0), radius: 14.5, x: -22, y: 101)
                        .overlay(
                            Text("CASH")
                                .font(Font.custom("Inter", size: 85))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 327, height: 74, alignment: .top)
                        )
                        .onTapGesture {
                            viewRouter.currentPage = .order
                        }
                    
                    Spacer() // Spacer between the rectangles
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 422, height: 230)
                        .background(Color(red: 0.18, green: 0.23, blue: 0.31))
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.13), radius: 0, x: 0, y: 0)
                        .shadow(color: .black.opacity(0.13), radius: 4.5, x: -1, y: 4)
                        .shadow(color: .black.opacity(0.11), radius: 8.5, x: -4, y: 16)
                        .shadow(color: .black.opacity(0.07), radius: 11, x: -8, y: 36)
                        .shadow(color: .black.opacity(0.02), radius: 13, x: -14, y: 65)
                        .shadow(color: .black.opacity(0), radius: 14.5, x: -22, y: 101)
                        .overlay(
                            Text("CREDIT")
                                .font(Font.custom("Inter", size: 85))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 327, height: 74, alignment: .top)
                        )
                    
                    Spacer() // Spacer on the right side
                }
                
                Spacer() // This will push the above HStack to the center
                
            }
            .frame(maxHeight: .infinity) // This will make the VStack take up the entire height of the screen
            
            
            if passwordShare || passwordEdit {
                ZStack{
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.01))
                        .onTapGesture {
                            if passwordShare {
                                passwordShare = false
                            } else {
                                passwordEdit = false
                            }
                            animate = false
                            isPasswordVisible = false
                            text = ""
                        }
                    if animate {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 505, height: 275)
                            .background(.white)
                            .cornerRadius(30)
                            .shadow(color: .black.opacity(0.13), radius: 12, x: -2, y: 11)
                            .shadow(color: .black.opacity(0.11), radius: 22, x: -10, y: 43)
                            .shadow(color: .black.opacity(0.07), radius: 29.5, x: -22, y: 96)
                            .shadow(color: .black.opacity(0.02), radius: 35, x: -40, y: 171)
                            .shadow(color: .black.opacity(0), radius: 38.5, x: -62, y: 268)
                            .overlay(
                                VStack{
                                    Spacer()
                                    Text("PASSWORD")
                                        .font(
                                            Font.custom("Inter", size: 40)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                    
                                        .foregroundColor(.black)
                                        .frame(width: 315, height: 58, alignment: .top)
                                        .padding(.top, 15)
                                    
                                    if isPasswordVisible {
                                        TextField("Enter password", text: $text)
                                            .padding(.horizontal)
                                            .frame(width: 410, height: 43)
                                            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                                            .cornerRadius(10)
                                            .overlay(
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "eye.fill")
                                                        .onTapGesture {
                                                            isPasswordVisible.toggle()
                                                        }
                                                }
                                                    .padding(.horizontal)
                                            )
                                    } else {
                                        SecureField("Enter password", text: $text)
                                            .padding(.horizontal)
                                            .frame(width: 410, height: 43)
                                            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                                            .cornerRadius(10)
                                            .overlay(
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "eye.slash.fill")
                                                        .onTapGesture {
                                                            isPasswordVisible.toggle()
                                                        }
                                                }
                                                    .padding(.horizontal)
                                            )
                                    }
                                    
                                    
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 132, height: 41)
                                            .background(Color(red: 0.55, green: 0.55, blue: 0.55))
                                            .cornerRadius(20)
                                            .overlay(
                                                Text("cancel")
                                                    .font(Font.custom("Inter", size: 24))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.white)
                                                    .frame(width: 99.85492, height: 21, alignment: .center)
                                            )
                                            .onTapGesture {
                                                if passwordShare {
                                                    passwordShare = false
                                                    
                                                } else {
                                                    passwordEdit = false
                                                }
                                                animate = false
                                                isPasswordVisible = false
                                                text = ""
                                            }
                                        
                                        Spacer()
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 132, height: 41)
                                            .background(Color(red: 0, green: 0.48, blue: 1))
                                            .cornerRadius(20)
                                            .overlay(
                                                Text("submit")
                                                    .font(Font.custom("Inter", size: 24))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.white)
                                                    .frame(width: 99.85492, height: 21, alignment: .center)
                                            )
                                            .onTapGesture {
                                                if text == password {
                                                    if passwordEdit {
                                                        viewRouter.currentPage = .edit
                                                        loadData(school: "Hersey") { loadedProducts in
                                                            productData.products = loadedProducts
                                                        }
                                                        
                                                        
                                                    }
                                                }
                                            }
                                        
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    Spacer()
                                }
                            )
                    }
                    
                }
                
            }
            
            
            
        }
    }
    
}
