//
//  favTableViewTests.swift
//  favTableViewTests
//
//  Created by Влад Купряков on 23.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import XCTest
@testable import stepikCourses
class favTableViewTests: XCTestCase {
    var favTable :favouriteTableViewController?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        favTable = favouriteTableViewController()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        favTable = nil
        super.tearDown()
    }
    
    func testSave() {
        let courseName = "math"
        let someData = Data()
        favTable?.save(name: courseName, imgData: someData)
        XCTAssert((favTable?.favCourses.isEmpty)!, "we didnt change it, it should be empty")
    }
    
    
}
