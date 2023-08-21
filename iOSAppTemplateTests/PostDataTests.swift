//
//  PostDataTests.swift
//  iOSAppTemplateTests
//
//  Created by apple on 21/08/23.
//

import XCTest
import CoreData

@testable import iOSAppTemplate
class PostDataTests: XCTestCase {
    
    // Mock NSManagedObjectContext for testing
    var mockContext: NSManagedObjectContext!
    var persistenceController: PersistenceController!
    
    override func setUp() {
        super.setUp()
        // Initialize the PersistenceController with an in-memory store
        persistenceController = PersistenceController(inMemory: true)
        
        // Get the managedObjectContext from the PersistenceController
        mockContext = persistenceController.container.viewContext
    }
    
    override func tearDown() {
        // Clean up resources after each test
        mockContext = nil
        super.tearDown()
    }
    
    //MARK:- Add post test cases
    func test_AddPostData() {
        // Given
        let downloadUrl = URL(string: "https://example.com/image.jpg")!
        let caption = "Test Caption"

        // When
        PersistenceController.shared.addPostData(downloadUrl: downloadUrl, caption: caption, context: mockContext)

        // Then
        let fetchRequest: NSFetchRequest<PostData> = PostData.fetchRequest()

        do {
            let result = try mockContext.fetch(fetchRequest)
            XCTAssertEqual(result.count, 1) // Ensure there's exactly one PostData entity in the context
            let postData = result.first!
            XCTAssertEqual(postData.caption, caption)
            XCTAssertEqual(postData.downloadUrl, downloadUrl)
            XCTAssertFalse(postData.isLiked) // Check if isLiked is initially false
        } catch {
            XCTFail("Error fetching PostData: \(error)")
        }
    }

    func test_AddPostDataWithEmptyCaption() {
        // Given
        let downloadUrl = URL(string: "https://example.com/image.jpg")!
        let caption = ""

        // When
        PersistenceController.shared.addPostData(downloadUrl: downloadUrl, caption: caption, context: mockContext)

        // Then
        // Fetch the newly created PostData from the context
        let fetchRequest: NSFetchRequest<PostData> = PostData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "caption == %@", caption)

        do {
            let result = try mockContext.fetch(fetchRequest)
            XCTAssertEqual(result.count, 1) // Ensure there's exactly one PostData with an empty caption
            let postData = result.first!
            XCTAssertEqual(postData.caption, caption)
            XCTAssertEqual(postData.downloadUrl, downloadUrl)
        } catch {
            XCTFail("Error fetching PostData: \(error)")
        }
    }
    
    //MARK:- Update caption test cases
    func test_UpdateCaption() {
        // Given
        let initialCaption = "Initial Caption"
        let updatedCaption = "Updated Caption"
        let postData = PostData(context: mockContext)
        postData.caption = initialCaption
        
        // When
        PersistenceController.shared.updateCaption(caption: updatedCaption, postData: postData, context: mockContext)
        
        // Then
        XCTAssertEqual(postData.caption, updatedCaption) // Check if the caption was updated
    }
    
    func testUpdateCaptionWithEmptyString() {
        // Given
        let initialCaption = "Initial Caption"
        let updatedCaption = ""
        let postData = PostData(context: mockContext)
        postData.caption = initialCaption
        
        // When
        PersistenceController.shared.updateCaption(caption: updatedCaption, postData: postData, context: mockContext)
        
        // Then
        XCTAssertEqual(postData.caption, updatedCaption) // Check if the caption was updated to an empty string
    }
    
    func testUpdateCaptionWithWhitespace() {
        // Given
        let initialCaption = "Initial Caption"
        let updatedCaption = "   " // Whitespace
        let postData = PostData(context: mockContext)
        postData.caption = initialCaption
        
        // When
        PersistenceController.shared.updateCaption(caption: updatedCaption, postData: postData, context: mockContext)
        
        // Then
        XCTAssertEqual(postData.caption, updatedCaption) // Check if the caption was updated to whitespace
    }
    
    func testUpdateCaptionWithSpecialCharacters() {
        // Given
        let initialCaption = "Initial Caption"
        let updatedCaption = "New Caption with @#$ Special Characters! 123"
        let postData = PostData(context: mockContext)
        postData.caption = initialCaption
        
        // When
        PersistenceController.shared.updateCaption(caption: updatedCaption, postData: postData, context: mockContext)
        
        // Then
        XCTAssertEqual(postData.caption, updatedCaption) // Check if the caption was updated with special characters
    }
    
    //MARK:- Update like test cases
    func testUpdateLikesStatusToTrue() {
        // Given
        let initialLikesStatus = false
        let updatedLikesStatus = true
        let postData = PostData(context: mockContext)
        postData.isLiked = initialLikesStatus
        
        // When
        PersistenceController.shared.updateLikesStatus(isLiked: updatedLikesStatus, postData: postData, context: mockContext)
        
        // Then
        XCTAssertTrue(postData.isLiked) // Check if isLiked was updated to true
    }
    
    func testUpdateLikesStatusToFalse() {
        // Given
        let initialLikesStatus = true
        let updatedLikesStatus = false
        let postData = PostData(context: mockContext)
        postData.isLiked = initialLikesStatus
        
        // When
        PersistenceController.shared.updateLikesStatus(isLiked: updatedLikesStatus, postData: postData, context: mockContext)
        
        // Then
        XCTAssertFalse(postData.isLiked) // Check if isLiked was updated to false
    }
    
    func testUpdateLikesStatusFromTrueToTrue() {
        // Given
        let initialLikesStatus = true
        let updatedLikesStatus = true
        let postData = PostData(context: mockContext)
        postData.isLiked = initialLikesStatus
        
        // When
        PersistenceController.shared.updateLikesStatus(isLiked: updatedLikesStatus, postData: postData, context: mockContext)
        
        // Then
        XCTAssertTrue(postData.isLiked) // Check if isLiked remains true
    }
    
    func testUpdateLikesStatusFromFalseToFalse() {
        // Given
        let initialLikesStatus = false
        let updatedLikesStatus = false
        let postData = PostData(context: mockContext)
        postData.isLiked = initialLikesStatus
        
        // When
        PersistenceController.shared.updateLikesStatus(isLiked: updatedLikesStatus, postData: postData, context: mockContext)
        
        // Then
        XCTAssertFalse(postData.isLiked) // Check if isLiked remains false
    }
}
