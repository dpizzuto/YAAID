//
//  FastCacheTest.swift
//
//  Created by Dario Pizzuto on 01/05/17.
//  Copyright © 2017 CesarePozzo. All rights reserved.
//

import XCTest

@testable import YAAID

class FastCacheTest: XCTestCase {
    
    let storedObject = NSArray(arrayLiteral: "1", "2")
    let key = "myKey"
    
    override func setUp() {
        super.setUp()
        FastCache.sharedInstance.put(object: storedObject, forKey: key)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_StoreObjectForKey(){
        let myArray = NSArray(arrayLiteral: "1", "2")
        FastCache.sharedInstance.put(object: myArray, forKey: "aKey")
        XCTAssertNotNil(FastCache.sharedInstance.retrieve(key: "aKey"))
    }
    
    
    func test_RetrieveValidObjectForKey(){
        if let array = FastCache.sharedInstance.retrieve(key: key) as? NSArray{
        XCTAssertEqual(storedObject, array)
        }
        else{
            XCTFail()
        }
    }
    
    func test_RetrieveKeyNotFound(){
        XCTAssertNil(FastCache.sharedInstance.retrieve(key: "aRandomKey"))
    }
    
    
    func test_invalidateCache(){
        let myArray = NSArray(arrayLiteral: "1", "2")
        FastCache.sharedInstance.put(object: myArray, forKey: "aKey")
        FastCache.sharedInstance.invalidate()
        XCTAssertNil(FastCache.sharedInstance.retrieve(key: "aKey"))
        
    }
    
    
}
