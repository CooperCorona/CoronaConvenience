//
//  DictionaryTest.swift
//  CoronaConvenience.Tests
//
//  Created by Cooper Knaak on 10/19/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

import XCTest

class DictionaryTest: XCTestCase {

    ///Tests the get(keys:) method with an empty dictionary.
    func testGetKeysEmptyDictionary() {
        let dict:[String:String] = [:]
        let keys = ["A", "B", "C"]
        
        let result = dict.get(keys: keys)
        XCTAssertEqual([], result)
    }
    
    ///Tests the get(keys:) method with an empty keys array.
    func testGetKeysEmptyKeys() {
        let dict:[String:String] = ["A": "a", "B": "b", "C": "c"]
        let keys:[String] = []
        
        let result = dict.get(keys: keys)
        XCTAssertEqual([], result)
    }
    
    ///Tests the get(keys:) method with given keys that are not
    ///in the dictionary.
    func testGetKeysInvalid() {
        let dict:[String:String] = ["A": "a", "B": "b", "C": "c"]
        let keys = ["D", "E", "F"]
        
        let result = dict.get(keys: keys)
        XCTAssertEqual([], result)
    }
    
    ///Tests the get(keys:) method with a keys array with 1 value.
    func testGetKeysOneKey() {
        let dict:[String:String] = ["A": "a", "B": "b", "C": "c"]
        let keys:[String] = ["B"]
        
        let result = dict.get(keys: keys)
        XCTAssertEqual(["b"], result)
    }
    
    ///Tests the get(keys:) method with a full array of keys.
    func testGetKeys() {
        let dict:[String:String] = ["A": "a", "B": "b", "C": "c"]
        let keys:[String] = ["A", "B", "C"]
        
        let result = dict.get(keys: keys)
        XCTAssertEqual(["a", "b", "c"], result)
    }
    
    ///Tests the get(keys:) method with a keys array containing
    ///some valid keys and some invalid keys.
    func testGetKeysSomeInvalid() {
        let dict:[String:String] = ["A": "a", "B": "b", "C": "c"]
        let keys:[String] = ["A", "D", "C", "E"]
        
        let result = dict.get(keys: keys)
        XCTAssertEqual(["a", "c"], result)
    }

}
