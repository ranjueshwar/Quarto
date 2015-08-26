//
//  CoreDataStackExtension.swift
//  Quarto
//
//  Created by Prathap Murthy on 23/06/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import CoreData

public extension CoreDataStack {
	
	
	func getPrivateContext() -> NSManagedObjectContext {
		let privateContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
		privateContext.persistentStoreCoordinator = CoreDataStack.coreDataStackInstance.context.persistentStoreCoordinator
		return privateContext
	}
}