import SwiftUI
import PhotosUI

import PhotosUI

struct ItemEdit: View 
{
    
    @EnvironmentObject var productData: ProductData
    @StateObject private var photoSelectorVM = PhotoSelectorViewModel()
    @State private var isClicked = false
    @Binding var data: CustomData
    var onDelete: (() -> Void)?

    var body: some View {
        VStack 
        {
            HStack 
            {
                PhotosPicker(
                    selection: $photoSelectorVM.selectedPhotos,
                    maxSelectionCount: 1,
                    matching: .images
                ) 
                {
                    Image("Plus")
                        .frame(width: 30, height: 30)
                        .offset(y: 25)
                        .offset(x: -5)
                }
                .onChange(of: photoSelectorVM.selectedPhotos) 
                { _ in
                    Task
                    {
                        print(photoSelectorVM.selectedPhotos)
                        await photoSelectorVM.convertDataToImage()
                    }
                }
                
                Spacer()

                Image("Minus")
                    .offset(y: 25)
                    .offset(x: 5)
                    .onTapGesture 
                    {
                        onDelete?()
                    }
            }
            .zIndex(2)

            Group 
            {
                if let image = photoSelectorVM.images.first 
                {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else 
                {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                }
            }
            .foregroundColor(.clear)
            .frame(width: 199, height: 273)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            .cornerRadius(20)
            .shadow(color: .black.opacity(isClicked ? 0.13 : 0), radius: 2.5, x: -1, y: 2)
            .shadow(color: .black.opacity(isClicked ? 0.11 : 0), radius: 4.5, x: -2, y: 8)
            .shadow(color: .black.opacity(isClicked ? 0.07 : 0), radius: 6, x: -5, y: 19)
            .shadow(color: .black.opacity(isClicked ? 0.02 : 0), radius: 7, x: -9, y: 34)
            .shadow(color: .black.opacity(isClicked ? 0 : 0), radius: 7.5, x: -14, y: 53)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 1.5)
                    .stroke(Color(red: 0, green: 0.48, blue: 1), lineWidth: isClicked ? 3 : 0)
            )
            .onTapGesture 
            {
                isClicked.toggle()
                if isClicked 
                {
                    productData.selectedProducts.append(data)
                } else 
                {
                    productData.selectedProducts.removeAll { $0.id == data.id }
                }
            }
            DoubleTextField(prod: $data)
                .offset(y:-5)
        }
        .frame(width: 199)
    }
}
