import SwiftUI
import PhotosUI
import FirebaseStorage

class PhotoSelectorViewModel: ObservableObject 
{
    
    @EnvironmentObject var productData: ProductData
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    
    @MainActor
    func convertDataToImage()
    {
        // reset the images array before adding more/new photos
        images.removeAll()
        
        if !selectedPhotos.isEmpty 
        {
            for eachItem in selectedPhotos 
            {
                Task {
                    if let imageData = try? await eachItem.loadTransferable(type: Data.self) 
                    {
                        if let image = UIImage(data: imageData) 
                        {
                            images.append(image)
                        }
                    }
                }
            }
        }
        // uncheck the images in the system photo picker
        selectedPhotos.removeAll()
    }
    
    func convertDataToImage(id:String, school: String)
    {
        // reset the images array before adding more/new photos
        images.removeAll()
        
        if !selectedPhotos.isEmpty
        {
            for eachItem in selectedPhotos
            {
                Task {
                    if let imageData = try? await eachItem.loadTransferable(type: Data.self)
                    {
                        if let image = UIImage(data: imageData)
                        {
                            images.append(image)
                        }
                    }
                    let img = Images(id:id, image: images[0])
//                    uploadToFirebase(id: img.id, image: img.image)
                    uploadToFirebase(img.image, imageName: img.id, school: school) { result in
                        switch result {
                        case .success(let url):
                            return
                        case .failure(let error):
                            return
                        }
                    }
                }
            }
        }
        // uncheck the images in the system photo picker
        selectedPhotos.removeAll()
    }
    
    func uploadToFirebase(_ image: UIImage, imageName: String, school: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(.failure(UploadImageError.failedToGetImageData))
            return
        }

        let storageRef = Storage.storage().reference().child("\(school)/\(imageName)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // Check if the image already exists
        storageRef.getMetadata { (existingMetadata, error) in
            if let error = error as NSError?, error.domain == StorageErrorDomain, error.code == StorageErrorCode.objectNotFound.rawValue {
                // The image does not exist, proceed with the upload
                self.uploadImage(storageRef: storageRef, imageData: imageData, metadata: metadata, completion: completion)
            } else if existingMetadata != nil {
                // The image exists, replace it with the new image
                self.uploadImage(storageRef: storageRef, imageData: imageData, metadata: metadata, completion: completion)
            } else {
                // Some other error occurred
                completion(.failure(error ?? UploadImageError.unknownError))
            }
        }
    }

    private func uploadImage(storageRef: StorageReference, imageData: Data, metadata: StorageMetadata, completion: @escaping (Result<URL, Error>) -> Void) {
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            guard metadata != nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(UploadImageError.unknownError))
                }
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                } else {
                    completion(.failure(UploadImageError.unknownError))
                }
            }
        }
    }

    enum UploadImageError: Error {
        case failedToGetImageData
        case unknownError
    }
    
}

struct PhotoSelectorView: View 
{
    @StateObject var vm = PhotoSelectorViewModel()
    let maxPhotosToSelect = 1
    
    var body: some View 
    {
        VStack 
        {
            ScrollView(.horizontal) 
            {
                LazyHGrid(rows: [GridItem(.fixed(300))]) {
                    ForEach(0..<vm.images.count, id: \.self) 
                    { index in
                        Image(uiImage: vm.images[index])
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            PhotosPicker(
                selection: $vm.selectedPhotos, // holds the selected photos from the picker
                maxSelectionCount: maxPhotosToSelect, // sets the max number of photos the user can select
                selectionBehavior: .ordered, // ensures we get the photos in the same order that the user selected them
                matching: .images // filter the photos library to only show images
            ) 
            {
                // this label changes the text of photo to match either the plural or singular case based on the value in maxPhotosToSelect
                Label("Select up to ^[\(maxPhotosToSelect) photo](inflect: true)", systemImage: "photo")
            }
        }
        .padding()
        .onChange(of: vm.selectedPhotos) { _, _ in
            vm.convertDataToImage()
        }
    }
}
