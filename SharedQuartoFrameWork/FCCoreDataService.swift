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
	let batchSize:UInt = 100
	let maxLimit:UInt = 1372
	let minLimit:UInt = 1
	
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
	
	public func getWords(wordsIds: [UInt], context: NSManagedObjectContext!)-> [QWord]!{
		
		var words: [QWord]!
		
		if wordsIds.count > 0 {
			let fetchRequest = NSFetchRequest(entityName: "Word")
			let predicate =
			NSPredicate(format: "wordId in %@", wordsIds)
			fetchRequest.predicate = predicate
			if let privateContext = context {
				
				do{
					let result = try privateContext.executeFetchRequest(fetchRequest) as! [QWord]
					words = result
					print("completd")
				}catch{
					print("Failed to fetch records in private queue")
				}
				
			}else {
				do{
					let result =
				 try DataManager.getContext().executeFetchRequest(fetchRequest) as! [QWord]
					
					words = result
				}catch{
					print("Failed to fetch records in main queue")
				}
			}
		}
		
		return words
	}
	
//	public func performBackgroundFetch()->[QWord]!{
//		var words: [QWord]!
//		let privateContext = DataManager.getContext(DataManager.DataManagerContextType.PrivateQueueConcurrencyType)
//	
//		privateContext.performBlock { () -> Void in
//			let wordsArr:[QWord]! = self.getWords(self.getRandomNumbersArray(1, upperLimit: 1372, batchSize: 25), context: privateContext)
//			
//			dispatch_async(dispatch_get_main_queue(), { () -> Void in
//				words = wordsArr
//	
//			})
//		} // close perform block
//	
//		return words
//	}
	
	public func getWordsData() -> [QWord]!{
	
		let words = self.getWords(self.getRandomNumbersArray(self.minLimit, upperLimit: self.maxLimit, batchSize: self.batchSize), context: nil)
		return words
	}
	
}
