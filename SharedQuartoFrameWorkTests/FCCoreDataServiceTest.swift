//
//  FCCoreDataService.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import UIKit
import XCTest
import SharedQuartoFrameWork


class FCCoreDataServiceTest: XCTestCase {
	
	var fcCoreDataService: FCCoreDataService!
	var randomNumbersArray: [UInt]!
	var batchSize: UInt = 20
	
	
	override func setUp() {
		super.setUp()
		
		fcCoreDataService = FCCoreDataService()
		randomNumbersArray = fcCoreDataService.getRandomNumbersArray(UInt(1), upperLimit: UInt(1372),batchSize: batchSize)
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		fcCoreDataService = nil
		randomNumbersArray = nil
		
		super.tearDown()
	}
	
	func testgetRandomNumbersArray() {
		var bs:UInt = 100
		XCTAssertEqual(UInt(fcCoreDataService.getRandomNumbersArray(1,upperLimit: 1372,batchSize: bs).count), bs, "Hunderd random numbers array is returned")
	}
	
	func testgetRandomNumbersArrayWithNoNegativeNumbers() {
		XCTAssertGreaterThan(fcCoreDataService.getRandomNumbersArray(1, upperLimit: 1372,batchSize: 5).first!, 0, "Positive numbers returned")
		
	}
	
	func testgetRandomNumbersArrayReturnsNil(){
		XCTAssertNil(fcCoreDataService.getRandomNumbersArray(1755, upperLimit: 1372,batchSize: 5), "Returns Nil")
		
	}
	
	func testgetWordsNotNil(){
	
		XCTAssertNotNil(fcCoreDataService.getWords(randomNumbersArray), "Records found")
	}
	
	func testgetWordsNil(){
		XCTAssertNil(fcCoreDataService.getWords([]), "No Records found")
	}
	
	func testgetWordsCountEqualsBatchSize	(){
		XCTAssertEqual(UInt(fcCoreDataService.getWords(randomNumbersArray).count), batchSize, "\(batchSize) records found")
	}
	
	func testgetFirstWord(){
		XCTAssertEqual(fcCoreDataService.getWords([1]).first!.charactersList, "CORW", "Returning first word")
	}
	
	func testPerformanceExample() {
		randomNumbersArray = fcCoreDataService.getRandomNumbersArray(UInt(1), upperLimit: UInt(1745),batchSize: 1745)
		// This is an example of a performance test case.
		self.measureBlock() {
			fcCoreDataService.getWords(randomNumbersArray)
		}
	}
	
	
	
	
}

