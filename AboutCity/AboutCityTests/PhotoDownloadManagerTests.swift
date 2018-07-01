//
//  PhotoDownloadManagerTests.swift
//  AboutCityTests
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import XCTest
@testable import AboutCity

class PhotoDownloadManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchPhotoError() {
        let promise = expectation(description: "Error")
        
        let request = PhotoDownloadManager.sharedInstance.retrieveImage(for: "", completion: { (image) in
            if let _ = image {
                XCTFail("Empty url returning invalid data")
            }
            else {
                promise.fulfill()
            }
        })
        XCTAssertNil(request)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchPhotoSuccess() {
        let promise = expectation(description: "Success")
        
        let url = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        let request = PhotoDownloadManager.sharedInstance.retrieveImage(for: url, completion: { (image) in
            if let _ = image {
                promise.fulfill()
            }
            else {
                XCTFail("Valid URL returned error")
            }
        })
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSaveCashe() {
        let promise = expectation(description: "Success")
        
        let url = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        let photoManager = PhotoDownloadManager.sharedInstance
        
        let _ = photoManager.retrieveImage(for: url, completion: { (image) in
            if let _ = image {
                photoManager.cache(image!, for: url)
                let cacheImage = photoManager.cachedImage(for: url)
                XCTAssertNotNil(cacheImage)
                promise.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
