//
//  QiitaKitTests.swift
//  QiitaKitTests
//
//  Created by 林達也 on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit
import XCTest
import QiitaKit
import APIKit


func test<T: RequestToken, U>(token: T.Type, obj: U) -> Bool {
    return (obj as? T.SerializedType) != nil
}

class QiitaKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        
        
        let object: AnyObject? = nil
        
        XCTAssertTrue(test(DeleteComment.self, 1), "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
