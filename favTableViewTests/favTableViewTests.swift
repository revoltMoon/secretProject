//
//  favTableViewTests.swift
//  favTableViewTests
//
//  Created by Влад Купряков on 23.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import XCTest
@testable import stepikCourses
class memoryTests: XCTestCase {
    var mem :Memory?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mem = Memory()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mem = nil
        super.tearDown()
    }
    
    func testSave() {
        let courseName = "math"
        let someData = Data()
        mem?.saveYourCourse(name: courseName, imgData: someData)
    }
    
    
}
