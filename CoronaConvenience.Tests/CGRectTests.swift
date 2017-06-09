//
//  CGRectTests.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 4/30/17.
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

class CGRect_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        let result = lhs + rhs
        return XCTAssert(result.origin.x == 6.0 && result.origin.y == 8.0 && result.size.width == 10.0 && result.size.height == 12.0)
    }
    
    func testSubtract() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        let result = lhs - rhs
        return XCTAssert(result.origin.x == -4.0 && result.origin.y == -4.0 && result.size.width == -4.0 && result.size.height == -4.0)
    }
    
    func testMultiply() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        let result = lhs * rhs
        return XCTAssert(result.origin.x == 5.0 && result.origin.y == 12.0 && result.size.width == 21.0 && result.size.height == 32.0)
    }
    
    func testDivide() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        let result = lhs / rhs
        return XCTAssert(result.origin.x == 0.2 && result.origin.y == 1.0 / 3.0 && result.size.width == 3.0 / 7.0 && result.size.height == 0.5)
    }
    
    func testAddAssignment() {
        var lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        lhs += rhs
        return XCTAssert(lhs.origin.x == 6.0 && lhs.origin.y == 8.0 && lhs.size.width == 10.0 && lhs.size.height == 12.0)
    }
    
    func testSubtractAssignment() {
        var lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        lhs -= rhs
        return XCTAssert(lhs.origin.x == -4.0 && lhs.origin.y == -4.0 && lhs.size.width == -4.0 && lhs.size.height == -4.0)
    }
    
    func testMultiplyAssignment() {
        var lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        lhs *= rhs
        return XCTAssert(lhs.origin.x == 5.0 && lhs.origin.y == 12.0 && lhs.size.width == 21.0 && lhs.size.height == 32.0)
    }
    
    func testDivideAssignment() {
        var lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs = CGRect(x: 5.0, y: 6.0, width: 7.0, height: 8.0)
        lhs /= rhs
        return XCTAssert(lhs.origin.x == 0.2 && lhs.origin.y == 1.0 / 3.0 && lhs.size.width == 3.0 / 7.0 && lhs.size.height == 0.5)
    }
    
    func testAddScalarLeft() {
        let lhs:CGFloat = 5.0
        let rhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let result = lhs + rhs
        XCTAssert(result.origin.x == 6.0 && result.origin.y == 7.0 && result.size.width == 8.0 && result.size.height == 9.0)
    }
    
    func testSubtractScalarLeft() {
        let lhs:CGFloat = 5.0
        let rhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let result = lhs - rhs
        XCTAssert(result.origin.x == 4.0 && result.origin.y == 3.0 && result.size.width == 2.0 && result.size.height == 1.0)
    }
    
    func testMultiplyScalarLeft() {
        let lhs:CGFloat = 5.0
        let rhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let result = lhs * rhs
        XCTAssert(result.origin.x == 5.0 && result.origin.y == 10.0 && result.size.width == 15.0 && result.size.height == 20.0)
    }
    
    func testDivideScalarLeft() {
        let lhs:CGFloat = 5.0
        let rhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let result = lhs / rhs
        XCTAssert(result.origin.x == 5.0 && result.origin.y == 2.5 && result.size.width == 5.0 / 3.0 && result.size.height == 1.25)
    }

    
    func testAddScalarRight() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs:CGFloat = 5.0
        let result = lhs + rhs
        XCTAssert(result.origin.x == 6.0 && result.origin.y == 7.0 && result.size.width == 8.0 && result.size.height == 9.0)
    }
    
    func testSubtractScalarRight() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs:CGFloat = 5.0
        let result = lhs - rhs
        XCTAssert(result.origin.x == -4.0 && result.origin.y == -3.0 && result.size.width == -2.0 && result.size.height == -1.0)
    }
    
    func testMultiplyScalarRight() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs:CGFloat = 5.0
        let result = lhs * rhs
        XCTAssert(result.origin.x == 5.0 && result.origin.y == 10.0 && result.size.width == 15.0 && result.size.height == 20.0)
    }
    
    func testDivideScalarRight() {
        let lhs = CGRect(x: 1.0, y: 2.0, width: 3.0, height: 4.0)
        let rhs:CGFloat = 5.0
        let result = lhs / rhs
        XCTAssert(result.origin.x == 0.2 && result.origin.y == 0.4 && result.size.width == 0.6 && result.size.height == 0.8)
    }

    
}
