//
//  FCCoreDataService.swift
//  FourCharacters
//
//  Created by Prathap Murthy on 02/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import CoreData

public class FCCoreDataService {
	
	public init(){
		
	}
	
	func randRange (lower: UInt , upper: UInt) -> UInt {
		return lower + UInt(arc4random_uniform(UInt32(upper - lower + UInt(1))))
	}
	
	public func getRandomNumbersArray(lowerLimit: UInt , upperLimit: UInt, batchSize: UInt)->[UInt]! {
		var randomNumbersArray:[UInt]!
		if upperLimit > lowerLimit {
			randomNumbersArray = []
			for _ in lowerLimit...batchSize {
				randomNumbersArray.append(randRange(lowerLimit, upper: upperLimit))
			}
		}
		return randomNumbersArray
	}
	
	public func getWords(wordsIds: [UInt])-> [Word]!{
		var words: [Word]!
		var error: NSError? = nil
		if wordsIds.count > 0 {
			let fetchRequest = NSFetchRequest(entityName: "Word")
			let predicate =
			NSPredicate(format: "wordId in %@", wordsIds)
			fetchRequest.predicate = predicate
				let result =
				 DataManager.getContext().executeFetchRequest(fetchRequest, error: &error) as! [Word]
				
				words = result
				
		}
		
		return words
	}
	
	
}
