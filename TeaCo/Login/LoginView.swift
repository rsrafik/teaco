import SwiftUI

struct LoginView: View 
{
    @StateObject var viewRouter:ViewRouter
    @EnvironmentObject var productData: ProductData
    
    @State var selected = false;
    @State var schoolClicked = "no school selected"
    @State var checkClicked = false;
    
    var body: some View {
        VStack {
            Text("Select School")
                .font(
                    Font.custom("Inter-Bold", size: 35)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 368, height: 51, alignment: .top)
                .padding(.top, 100)
            
            ZStack 
            {
                if selected == false 
                {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 368, height: 59)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: 1.5)
                                .stroke(Color(red: 0.55, green: 0.55, blue: 0.55), lineWidth: 3)
                        )
                    
                    HStack 
                    {
                        Text(schoolClicked)
                            .font(Font.custom("Inter-Regular", size: 25))
                            .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
                            .frame(width: 241, height: 34, alignment: .leading)
                            .padding(.leading, 20)
                        Spacer()
                        Image("Unequip")
                            .frame(width: 28.29016, height: 22.5)
                            .padding(.trailing)
                            .onTapGesture 
                            {
                                selected = !selected
                                
                            }
                    }
                }
                
                if selected == true 
                {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 368, height: 334)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
                        .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 2)
                        .shadow(color: .black.opacity(0.09), radius: 4.5, x: 0, y: 9)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 19)
                        .shadow(color: .black.opacity(0.01), radius: 7, x: 0, y: 34)
                        .shadow(color: .black.opacity(0), radius: 7.5, x: 0, y: 53)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: 1.5)
                                .stroke(Color(red: 0.55, green: 0.55, blue: 0.55), lineWidth: 3)
                        )
                        .offset(y:137)
                        .overlay(
                            VStack (spacing: 0){
                                HStack 
                                {
                                    Text(schoolClicked)
                                        .font(Font.custom("Inter-Regular", size: 25))
                                        .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
                                        .frame(width: 241, height: 59, alignment: .leading)
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                    
                                    Image("Equip")
                                        .frame(width: 28.29016, height: 22.5)
                                        .padding(.trailing)
                                        .onTapGesture 
                                        {
                                            selected = !selected
                                        }
                                }
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 368, height: 46)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .overlay(
                                        Rectangle()
                                            .inset(by: 1.5)
                                            .stroke(Color(red: 0.55, green: 0.55, blue: 0.55), lineWidth: 3)
                                    )
                                    .overlay (
                                        HStack
                                        {
                                            Text("Hersey")
                                                .font(Font.custom("Inter", size: 25))
                                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                .frame(width: 241, height: 34, alignment: .leading)
                                                .padding(.leading, 20)
                                                .padding(.top, 4)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    )
                                    .onTapGesture 
                                    {
                                        selected = false
                                        if schoolClicked == "Hersey"
                                        {
                                            schoolClicked = "no school selected"
                                        } else 
                                        {
                                            schoolClicked = "Hersey"
                                        }
                                    }
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 362, height: 43)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .overlay (
                                        HStack{
                                            Text("Buffalo Grove")
                                                .font(Font.custom("Inter", size: 25))
                                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                .frame(width: 241, height: 34, alignment: .leading)
                                                .padding(.leading, 20)
                                                .padding(.top, 4)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    )
                                    .onTapGesture 
                                    {
                                        if schoolClicked == "Buffalo Grove" 
                                        {
                                            schoolClicked = "no school selected"
                                        } else 
                                        {
                                            schoolClicked = "Buffalo Grove"
                                        }
                                        selected = false
                                    }
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 368, height: 48)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .overlay(
                                        Rectangle()
                                            .inset(by: 1.5)
                                            .stroke(Color(red: 0.55, green: 0.55, blue: 0.55), lineWidth: 3)
                                    )
                                    .overlay (
                                        HStack{
                                            Text("Prospect")
                                                .font(Font.custom("Inter", size: 25))
                                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                .frame(width: 241, height: 34, alignment: .leading)
                                                .padding(.leading, 20)
                                                .padding(.top, 4)
                                            Spacer()
                                        }
                                        
                                    )
                                    .onTapGesture 
                                    {
                                        if schoolClicked == "Prospect" 
                                        {
                                            schoolClicked = "no school selected"
                                        } else 
                                        {
                                            schoolClicked = "Prospect"
                                        }
                                        selected = false
                                    }
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 362, height: 43)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .overlay (
                                        HStack
                                        {
                                            Text("Rolling Meadows")
                                                .font(Font.custom("Inter", size: 25))
                                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                .frame(width: 241, height: 34, alignment: .leading)
                                                .padding(.leading, 20)
                                                .padding(.top, 4)
                                            Spacer()
                                        }
                                        
                                    )
                                    .onTapGesture 
                                    {
                                        if schoolClicked == "Rolling Meadows" 
                                        {
                                            schoolClicked = "no school selected"
                                        } else 
                                        {
                                            schoolClicked = "Rolling Meadows"
                                        }
                                        selected = false
                                    }
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 368, height: 48)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .overlay(
                                        Rectangle()
                                            .inset(by: 1.5)
                                            .stroke(Color(red: 0.55, green: 0.55, blue: 0.55), lineWidth: 3)
                                    )
                                    .overlay (
                                        HStack{
                                            Text("Elk Grove")
                                                .font(Font.custom("Inter", size: 25))
                                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                .frame(width: 241, height: 34, alignment: .leading)
                                                .padding(.leading, 20)
                                                .padding(.top, 4)
                                            
                                            Spacer()
                                        }
                                        
                                    )
                                    .onTapGesture 
                                    {
                                        if schoolClicked == "Elk Grove"
                                        {
                                            schoolClicked = "no school selected"
                                        } else 
                                        {
                                            schoolClicked = "Elk Grove"
                                        }
                                        selected = false
                                    }
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 362, height: 43)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .cornerRadius(6)
                                    .overlay (
                                        HStack
                                        {
                                            Text("Wheeling")
                                                .font(Font.custom("Inter", size: 25))
                                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                .frame(width: 241, height: 34, alignment: .leading)
                                                .padding(.leading, 20)
                                                .padding(.top, 4)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    )
                                    .onTapGesture 
                                    {
                                        if schoolClicked == "Wheeling" 
                                        {
                                            schoolClicked = "no school selected"
                                        } else 
                                        {
                                            schoolClicked = "Wheeling"
                                        }
                                        selected = false
                                    }
                            }
                                .offset(y:135)
                        )
                }
            }
            .zIndex(4)
            .frame(width: 368, height: 59)
            .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
            .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.09), radius: 2.5, x: 0, y: 5)
            .shadow(color: .black.opacity(0.05), radius: 3.5, x: 0, y: 12)
            .shadow(color: .black.opacity(0.01), radius: 4.5, x: 0, y: 22)
            .shadow(color: .black.opacity(0), radius: 5, x: 0, y: 34)
            
            HStack 
            {
                ZStack
                {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 24, height: 24)
                        .background(.white)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.4)
                                .stroke(.black, lineWidth: 0.8)
                        )
                        .onTapGesture{
                            checkClicked = !checkClicked
                        }
                    if checkClicked == true 
                    {
                        Image("Check")
                            .frame(width: 31, height: 31)
                            .onTapGesture
                            {
                                checkClicked = !checkClicked
                            }
                    }
                }
                .frame(width: 31)
                
                Text("Stay signed in")
                    .font(Font.custom("Inter-Regular", size: 20))
                    .foregroundColor(.black)
                    .frame(width: 146, height: 30, alignment: .topLeading)
                    .padding(.top, 15)
                    .padding(.leading, 1)
                
                Spacer()
                
            }
            .frame(width: 368, height: 30)
            .padding(.top, 10)
            .padding(.bottom, 15)
            .padding(.leading, 15)
            
            ZStack 
            {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 286, height: 49)
                    .background(Color(red: 0.55, green: 0.55, blue: 0.55))
                    .cornerRadius(20)
                
                Text("SIGN IN")
                    .font(
                        Font.custom("Inter-Bold", size: 30)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 268, height: 42, alignment: .top)
                    .padding(.top, 17)
                    .onTapGesture 
                    {
                        if schoolClicked != "no school selected" 
                        {
                            productData.school = schoolClicked
                            viewRouter.currentPage = .cashcred
                        }
                    }
            }
            .frame(width: 286, height: 49)
            .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
            .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 2)
            .shadow(color: .black.opacity(0.09), radius: 4.5, x: -2, y: 8)
            .shadow(color: .black.opacity(0.05), radius: 6, x: -4, y: 19)
            .shadow(color: .black.opacity(0.01), radius: 7, x: -7, y: 34)
            .shadow(color: .black.opacity(0), radius: 7.5, x: -11, y: 53)
        }
        
    }
}
