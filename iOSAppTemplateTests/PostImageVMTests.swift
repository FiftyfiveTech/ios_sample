//
//  PostImageVMTests.swift
//  iOSAppTemplateTests
//
//  Created by apple on 22/08/23.
//

import Foundation
import XCTest
import Combine

@testable import iOSAppTemplate
class PostImageVMTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_getPostImagesData_success() {
        //Arrange
        let networkManager = NetworkManager.shared
        let expectation = self.expectation(description: "Valid_URL_Returns_Success")
        
        //Act
        networkManager.getData(endpoint: .list, type: PostImages.self)
            .sink { completion in
                // Assert
                
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let err):
                    print("Error occured with description: \(err.localizedDescription)")
                }
            } receiveValue: { postImages in
                XCTAssertNotNil(postImages)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_getPostImagesData_failure() {
        //Arrange
        let networkManager = NetworkManager.shared
        let expectation = self.expectation(description: "InValid_URL_Returns_Success")
        
        networkManager.getData(endpoint: .list, type: PostImage.self)
            .sink { completion in
                // Assert
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let err):
                    print("Error occured with description: \(err.localizedDescription)")
                    XCTAssertNotNil(err)
                    XCTAssertEqual("The data couldn’t be read because it isn’t in the correct format.", err.localizedDescription)
                    expectation.fulfill()
                }
            } receiveValue: { postImages in
                XCTAssertNil(postImages)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
    }
}
