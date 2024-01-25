//
//  Classes.swift
//  TeaCo
//
//  Created by Rachel Rafik on 1/25/24.
//

import Foundation
import UIKit

class CustomData: ObservableObject, Identifiable
{
    let id: String
    @Published var name: String
    @Published var price: Double

    init(id: String, name: String, price: Double)
    {
        self.id = id
        self.name = name
        self.price = price
    }
}

class Images: ObservableObject, Identifiable
{
    let id: String
    @Published var image: UIImage

    init(id: String, image:UIImage)
    {
        self.id = id
        self.image = image
    }
}
