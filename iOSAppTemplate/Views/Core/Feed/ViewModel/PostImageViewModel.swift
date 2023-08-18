//
//  PostImageViewModel.swift
//  iOSAppTemplate
//
//  Created by apple on 10/08/23.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class PostImageViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    var postImages = PostImages()
    
    func getPostImagesData(context: NSManagedObjectContext) {
        NetworkManager.shared.getData(endpoint: .list, type: PostImages.self)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let err):
                    print("Error occured with description: \(err.localizedDescription)")
                }
            } receiveValue: { [weak self] postImageData in
                print(postImageData)
                self?.postImages = postImageData
                postImageData.forEach { postImage in
                    PersistenceController.shared.addPostData(downloadUrl: postImage.downloadURL, caption: "Default caption...", context: context)
                }
            }
            .store(in: &cancellables)
    }
}
