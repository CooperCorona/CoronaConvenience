//
//  CGPointTests.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 4/29/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

import Foundation
import XCTest
#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif
import CoronaConvenience

class CGPoint_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        let result = lhs + rhs
        XCTAssert(result.x == 4.0 && result.y == 6.0)
    }
    
    func testSubtract() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        let result = lhs - rhs
        XCTAssert(result.x == -2.0 && result.y == -2.0)
    }
    
    func testMultiply() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        let result = lhs * rhs
        XCTAssert(result.x == 3.0 && result.y == 8.0)
    }
    
    func testDivide() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        let result = lhs / rhs
        XCTAssert(result.x == 1.0 / 3.0 && result.y == 0.5)
    }
    
    func testAddAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        lhs += rhs
        XCTAssert(lhs.x == 4.0 && lhs.y == 6.0)
    }
    
    func testSubtractAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        lhs -= rhs
        XCTAssert(lhs.x == -2.0 && lhs.y == -2.0)
    }
    
    func testMultiplyAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        lhs *= rhs
        XCTAssert(lhs.x == 3.0 && lhs.y == 8.0)
    }
    
    func testDivideAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs = CGPoint(x: 3.0, y: 4.0)
        lhs /= rhs
        XCTAssert(lhs.x == 1.0 / 3.0 && lhs.y == 0.5)
    }
    
    func testAddScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGPoint(x: 1.0, y: 2.0)
        let result = lhs + rhs
        XCTAssert(result.x == 4.0 && result.y == 5.0)
    }
    
    func testSubtractScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGPoint(x: 1.0, y: 2.0)
        let result = lhs - rhs
        XCTAssert(result.x == 2.0 && result.y == 1.0)
    }
    
    func testMultiplyScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGPoint(x: 1.0, y: 2.0)
        let result = lhs * rhs
        XCTAssert(result.x == 3.0 && result.y == 6.0)
    }
    
    func testDivideScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGPoint(x: 1.0, y: 2.0)
        let result = lhs / rhs
        XCTAssert(result.x == 3.0 && result.y == 1.5)
    }
    
    func testAddScalarRight() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs + rhs
        XCTAssert(result.x == 4.0 && result.y == 5.0)
    }
    
    func testSubtractScalarRight() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs - rhs
        XCTAssert(result.x == -2.0 && result.y == -1.0)
    }
    
    func testMultiplyScalarRight() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs * rhs
        XCTAssert(result.x == 3.0 && result.y == 6.0)
    }
    
    func testDivideScalarRight() {
        let lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs / rhs
        XCTAssert(result.x == 1.0 / 3.0 && result.y == 2.0 / 3.0)
    }
    
    func testAddScalarAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        lhs += rhs
        XCTAssert(lhs.x == 4.0 && lhs.y == 5.0)
    }
    
    func testSubtractScalarAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        lhs -= rhs
        XCTAssert(lhs.x == -2.0 && lhs.y == -1.0)
    }
    
    func testMultiplyScalarAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        lhs *= rhs
        XCTAssert(lhs.x == 3.0 && lhs.y == 6.0)
    }
    
    func testDivideScalarAssignment() {
        var lhs = CGPoint(x: 1.0, y: 2.0)
        let rhs:CGFloat = 3.0
        lhs /= rhs
        XCTAssert(lhs.x == 1.0 / 3.0 && lhs.y == 2.0 / 3.0)
    }
    
}
