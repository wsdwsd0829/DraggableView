//
//  DraggableViewTests.swift
//  DraggableViewTests
//
//  Created by sidawang on 2/27/16.
//  Copyright © 2016 sidex. All rights reserved.
//

import XCTest
@testable import DraggableView

class DraggableViewTests: XCTestCase {
    var tb:TrashBin!
    var dw1, dw2, dw3:WSDDraggableView!
    override func setUp() {
        super.setUp()
        tb = TrashBin()
        dw1 = WSDDraggableView(frame:CGRect(x: 0, y: 0, width: 100, height: 100),trashDelegate: tb)
        dw2 = WSDDraggableView(frame:CGRect(x: 0, y: 100, width: 100, height: 100),trashDelegate:tb)
        dw3 = WSDDraggableView(frame:CGRect(x: 0, y: 200, width: 100, height: 100),trashDelegate: tb)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        tb = nil
        dw1 = nil; dw2 = nil; dw3 = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testTrashOne(){
        dw1.doTrashing()
        XCTAssert(tb.garbages.count == 1, "trash count not equal to 1 when dw1 trashed")
    }
    
    func testTrashThree(){
        dw1.doTrashing()
        dw2.doTrashing()
        dw3.doTrashing()
        XCTAssert(tb.garbages.count == 3, "trash count not equal to 1 when dw1 & dw2 trashed")
    }
    
    //?? propert to call another test method
    func testTrashStatus(){
        testTrashThree()
        for trash in tb.garbages {
            XCTAssert( trash.status == .Trashed, "trash \(trash) in trashBin is not of correct Status")
        }
    }
    
    func testRestoreTrashAtIndex(){
        testTrashThree()
        tb.restoreTrash(tb.garbages[0])
         XCTAssert( tb.garbages.count == 2, "trash bin does not have 2 trash in trashBin when first is removed")
         XCTAssert( dw1.status == .Alive, "dw1 is not Alive after restore from trashBin")
    }

    func testRestoreAll(){
        testTrashThree()
        tb.restoreAll()
        XCTAssert( tb.garbages.count == 0, "trash bin not empty")
        XCTAssert( dw1.status == .Alive, "dw1 is not Alive after restore from trashBin")
        XCTAssert( dw2.status == .Alive, "dw2 is not Alive after restore from trashBin")
        XCTAssert( dw3.status == .Alive, "dw3 is not Alive after restore from trashBin")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
