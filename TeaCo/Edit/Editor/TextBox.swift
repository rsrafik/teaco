import SwiftUI

struct DoubleTextField: View 
{

    @State private var item: String
    @State private var price: String
    @Binding var prod: CustomData

    init(prod: Binding<CustomData>) 
    {
        self._prod = prod
        self._item = State(initialValue: prod.wrappedValue.name)
        self._price = State(initialValue: String(format: "%.2f", prod.wrappedValue.price))
    }

    var body: some View 
    {
        VStack(spacing: 0) 
        {
            TextField("Item", text: $item)
            .onChange(of: item) 
            { newValue in
                prod.name = newValue
            }
            .offset(x: -4)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.white)
            .overlay(
                HStack 
                {
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 15, height: 15)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        )
                        .padding(8)
                        .contentShape(Circle())
                        .onTapGesture 
                        {
                            self.item = ""
                        }
                }
            )

            Divider()
                .background(Color.gray)

            TextField("Price", text: $price)
            .onChange(of: price) { newValue in
                if let priceValue = Double(newValue) 
                {
                    prod.price = priceValue
                }
            }
            .offset(x: -4)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.white)
            .overlay(
                HStack 
                {
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 15, height: 15)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        )
                        .padding(8)
                        .contentShape(Circle())
                        .onTapGesture 
                        {
                            self.price = ""
                        }
                }
            )
        }
        .frame(width: 185)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}
