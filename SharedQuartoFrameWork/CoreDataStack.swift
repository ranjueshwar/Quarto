//
//  CoreDataStack.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import CoreData

public class CoreDataStack {
	
	public let context:NSManagedObjectContext
	let psc:NSPersistentStoreCoordinator
	let model:NSManagedObjectModel
	public var store:NSPersistentStore?
	public static let coreDataStackInstance = CoreDataStack()
	
	public init() {
		let sharedAppGroup = "group.com.ranju.Quarto"
		let modelName = "FourCharactersModel"
		let databaseName = "FourCharactersDatabase.sqlite"
		
		//let bundle = NSBundle.mainBundle()
		let bundle = NSBundle(identifier: "com.ranju.SharedQuartoFrameWork")
		let modelURL =
		bundle?.URLForResource(modelName, withExtension:"momd")
		model = NSManagedObjectModel(contentsOfURL: modelURL!)!
		
		psc =
			NSPersistentStoreCoordinator(managedObjectModel:model)
		
		context = NSManagedObjectContext(
			concurrencyType: .MainQueueConcurrencyType)
		context.persistentStoreCoordinator = psc
		
		let sharedContainerURL: NSURL? = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(sharedAppGroup)
		
		let storeURL = sharedContainerURL!.URLByAppendingPathComponent(databaseName)
		
	
		
		// 1
		let seededDatabaseURL = bundle?
			.URLForResource("FourCharactersDatabase",
				withExtension: "sqlite")
		
		// 2
		var fileManagerError:NSError? = nil
		let didCopyDatabase = NSFileManager.defaultManager()
			.copyItemAtURL(seededDatabaseURL!, toURL: storeURL,
				error: &fileManagerError)
		
		// 3
		if didCopyDatabase {
			
			// 4
			fileManagerError = nil
			let seededSHMURL = bundle?
				.URLForResource("FourCharactersDatabase",
					withExtension: "sqlite-shm")
			let shmURL = sharedContainerURL!.URLByAppendingPathComponent(
				"FourCharactersDatabase.sqlite-shm")
			
			let didCopySHM = NSFileManager.defaultManager()
				.copyItemAtURL(seededSHMURL!, toURL: shmURL,
					error: &fileManagerError)
			if !didCopySHM {
				println("Error seeding Core Data: \(fileManagerError)")
				abort()
			}
			
			// 5
			fileManagerError = nil
			let walURL = sharedContainerURL!.URLByAppendingPathComponent(
				"FourCharactersDatabase.sqlite-wal")
			let seededWALURL = bundle?
				.URLForResource("FourCharactersDatabase",
					withExtension: "sqlite-wal")
			
			let didCopyWAL = NSFileManager.defaultManager()
				.copyItemAtURL(seededWALURL!, toURL: walURL,
					error: &fileManagerError)
			if !didCopyWAL {
				println("Error seeding Core Data: \(fileManagerError)")
				abort()
			}
			
			println("Seeded Core Data")
		}
		
		// 6
		var error: NSError? = nil
		let options = [NSInferMappingModelAutomaticallyOption:true,
			NSMigratePersistentStoresAutomaticallyOption:true]
		store = psc.addPersistentStoreWithType(NSSQLiteStoreType,
			configuration: nil,
			URL: storeURL,
			options: options,
			error: &error)
		
		// 7
		if store == nil {
			println("Error adding persistent store: \(error)")
			abort()
		}
	}
	
	func applicationDocumentsDirectory() -> NSURL {
  
		let fileManager = NSFileManager.defaultManager()
  
		let urls =
		fileManager.URLsForDirectory(.DocumentDirectory,
			inDomains: .UserDomainMask) as! [NSURL]
  
		return urls[0]
	}
	
	func saveContext() {
		context.performBlock { () -> Void in
			var error: NSError? = nil
			if self.context.hasChanges && !self.context.save(&error) {
				println("Could not save: \(error), \(error?.userInfo)")
				abort()
			}
		}
	}
	
}

