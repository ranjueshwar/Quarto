//
//  CoreDataStackTest.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import UIKit
import XCTest
import SharedQuartoFrameWork

class CoreDataStackTest: XCTestCase {
	
	var coreDataStack: CoreDataStack!
	
	override func setUp() {
		super.setUp()
		self.coreDataStack = CoreDataStack.coreDataStackInstance
		
	}
	
	override func tearDown() {
		self.coreDataStack = nil
		super.tearDown()
	}
	
	func testCoreData() {
		XCTAssertNotNil(self.coreDataStack, "CoreData object is not nil")
		XCTAssertNotNil(self.coreDataStack.store,"Persistent Store is not nil")
		XCTAssertNotNil(self.coreDataStack.context,"Context Store is not nil")
	}
	
	func testStoreTypeofCoreData(){
		var storeType = self.coreDataStack.store!.type
		XCTAssertEqual(storeType, "SQLite", "StoreType is SQLite")
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measureBlock() {
			self.coreDataStack = CoreDataStack.coreDataStackInstance
		}
	}
	
}
