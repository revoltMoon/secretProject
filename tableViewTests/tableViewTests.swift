//
//  tableViewTests.swift
//  tableViewTests
//
//  Created by Влад Купряков on 22.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import XCTest
@testable import stepikCourses
class stepikCoursesTests: XCTestCase {
    var stepByStep : tableViewController!
    
    override func setUp() {
        super.setUp()
        stepByStep = tableViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        stepByStep = nil
        super.tearDown()
    }
    
    
    func testGetNames() {
        let names = ["math", "russian", "eng"]
        let names2 = [""]
        stepByStep.getNames(array: names)
        XCTAssertEqual(stepByStep.coursesName.count, 3, "oh, something went wrong")
        stepByStep.getNames(array: names2)
        XCTAssertEqual(stepByStep.coursesName.count, 4, "oh, something went wrong")
    }
    
    func testGetImg() {
        let img = [UIImage]()
        stepByStep.getImage(array: img)
        XCTAssertEqual(stepByStep.imgArr.count, 0, "imgArr size is wrong")
    }
    
    func testScaleImg() {
        let img = UIImage()
       XCTAssertEqual(stepByStep.scaleImage(img: img).size.height, 90, "size is not correct")
    }
    
    
    func testAddImgAndNameInDict() {
        stepByStep.imgArr = [UIImage(), UIImage()]
        stepByStep.addImgAndNameInDict()
        XCTAssert(stepByStep.coursesNamesAndImages.isEmpty, "your dictionary is not empty")
    }
}
