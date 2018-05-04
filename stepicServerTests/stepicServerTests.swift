//
//  testStepicServer.swift
//  testStepicServer
//
//  Created by Влад Купряков on 23.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import XCTest
@testable import stepikCourses
class testStepicServer: XCTestCase {
    var stepServer: stepikServer?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        stepServer = stepikServer()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        stepServer = nil
        super.tearDown()
    }
    
    func testStepic(){
        self.measure {
            stepServer?.getCourse(ourPage: 1)
        }
    }
}
