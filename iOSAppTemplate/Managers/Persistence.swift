//
//  Persistence.swift
//  iOSAppTemplate
//
//  Created by apple on 03/08/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "iOSAppTemplate")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!! Woohoo!!")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func addPostData(downloadUrl: URL, caption: String, context: NSManagedObjectContext) {
        let postData = PostData(context: context)
        postData.id = UUID()
        postData.caption = caption
        postData.date = Date()
        postData.downloadUrl = downloadUrl
        postData.isLiked = false
        save(context: context)
    }
    
    func updateCaption(caption: String, postData: PostData, context: NSManagedObjectContext) {
        postData.caption = caption
        save(context: context)
    }
    
    func updateLikesStatus(isLiked: Bool, postData: PostData, context: NSManagedObjectContext) {
        postData.isLiked = isLiked
        save(context: context)
    }
}
