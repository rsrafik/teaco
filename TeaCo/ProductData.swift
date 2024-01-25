//
//  ProductData.swift
//  TeaCo
//
//  Created by Rachel Rafik on 1/25/24.
//

import Foundation
import SwiftUI
import Firebase

class ProductData: ObservableObject
{
    
    @StateObject private var vm = PhotoSelectorViewModel()
    @Published var selectedProducts: [CustomData] = []
    @Published var deletedItems: [CustomData] = []
    @Published var products: [CustomData] = []
    @Published var addedProducts: [CustomData] = []
    @Published var comboProducts: [CustomData] = []
    @Published var images: [Images] = []
    @Published var id: String = ""
    @Published var school: String = ""
    @Published var mainColor: String = ""
    @Published var subColor: String = ""
    @Published var logo: Image = Image("NoImage")
    
    func updateImage(for id: String, with newImage: UIImage)
    {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].image = newImage
        } else
        {
            let newImageData = Images(id: id, image: newImage)
            images.append(newImageData)
        }
    }
}
