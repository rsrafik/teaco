//
//  FirebaseGetters.swift
//  TeaCo
//
//  Created by Rachel Rafik on 1/25/24.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import Combine
import Firebase

func loadData(school: String, completion: @escaping ([CustomData]) -> Void)
{
    let ref = Database.database().reference().child(school).child("Products")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
        var items: [CustomData] = []

        for child in snapshot.children
        {
            if let childSnapshot = child as? DataSnapshot,
               let dictionary = childSnapshot.value as? [String: Any],
               let name = dictionary["Name"] as? String,
               let price = dictionary["Price"] as? Double
            {
                let dataItem = CustomData(id: childSnapshot.key, name: name , price: price)
                items.append(dataItem)
            }
        }
        completion(items)
    })
    { (error) in
        completion([])
    }
}

func fetchImagesWithNames(schoolName: String, completion: @escaping ([Images]?) -> Void) 
{
    let storage = Storage.storage()
        let storageRef = storage.reference().child(schoolName)

        storageRef.listAll { (result, error) in
            if let error = error 
            {
                completion(nil)
                return
            }

            var imagePairs: [Images] = []
            let group = DispatchGroup()

            for item in result!.items 
            {
                group.enter()

                // Download each image
                item.getData(maxSize: 4 * 1024 * 1024) { data, error in
                    if let error = error 
                    {
                    } else if let data = data, let image = UIImage(data: data) 
                    {
                        let imageName = item.name
                        imagePairs.append(Images(id: imageName, image: image))
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                completion(imagePairs)
            }
        }
    }

func fetchColors(_ school: String, completion: @escaping ([String: String]) -> Void) {
    let ref = Database.database().reference(withPath: "\(school)/Colors")
    var mainColor: String = ""
    var subColor: String = ""

    let group = DispatchGroup()

    group.enter()
    ref.child("Main").observeSingleEvent(of: .value) { snapshot in
        if let main = snapshot.value as? String {
            mainColor = main
        }
        group.leave()
    }

    group.enter()
    ref.child("Sub").observeSingleEvent(of: .value) { snapshot in
        if let sub = snapshot.value as? String {
            subColor = sub
        }
        group.leave()
    }

    group.notify(queue: .main) {
        completion(["main": mainColor, "sub": subColor])
    }
}

func fetchLogo(_ school: String, completion: @escaping (UIImage?) -> Void) {
    let storage = Storage.storage()
    let storageRef = storage.reference().child("\(school)/\(school).png")

    storageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
        if let error = error {
            print("Error occurred: \(error)")
            completion(nil)
        } else if let data = data, let image = UIImage(data: data) {
            completion(image)
        } else {
            completion(nil)
        }
    }
}
