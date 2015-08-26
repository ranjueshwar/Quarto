//
//  CoreDataStack.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import CoreData

@objc(CoreDataStack)
public class CoreDataStack: NSObject {
	
	public let context:NSManagedObjectContext
	let psc:NSPersistentStoreCoordinator
	let model:NSManagedObjectModel
	public var store:NSPersistentStore?
	public static let coreDataStackInstance = CoreDataStack(identifier: Bundle.identifier)
	
 public struct Bundle {
	#if os(iOS)
	public static let identifier = "com.ranju.QFramework"
	#elseif os(watchOS)
	public static let identifier = "com.ranju.QFrameworkWatch"
	#endif
	}
	
	public init(identifier: String) {
		
		let modelName = "FourCharactersModel"
		let databaseName = "FourCharactersDatabase.sqlite"
		
		let bundle = NSBundle(identifier: identifier)!
		let modelURL =
		bundle.URLForResource(modelName, withExtension:"momd")
		model = NSManagedObjectModel(contentsOfURL: modelURL!)!
		
		psc = NSPersistentStoreCoordinator(managedObjectModel:model)
		
		context = NSManagedObjectContext(
			concurrencyType: .MainQueueConcurrencyType)
		context.persistentStoreCoordinator = psc
		super.init()
		let documentsURL = applicationDocumentsDirectory()
		
		let storeURL = documentsURL.URLByAppendingPathComponent(databaseName)
		
		
		
		// 1
		let seededDatabaseURL = bundle
			.URLForResource("FourCharactersDatabase",
				withExtension: "sqlite")
		
		// 2
		var fileManagerError:NSError? = nil
		let didCopyDatabase: Bool
		do {
			try NSFileManager.defaultManager()
				.copyItemAtURL(seededDatabaseURL!, toURL: storeURL)
			didCopyDatabase = true
		} catch let error as NSError {
			fileManagerError = error
			didCopyDatabase = false
		}
		
		// 3
		if didCopyDatabase {
			
			// 4
			fileManagerError = nil
			let seededSHMURL = bundle
				.URLForResource("FourCharactersDatabase",
					withExtension: "sqlite-shm")
			let shmURL = documentsURL.URLByAppendingPathComponent(
				"FourCharactersDatabase.sqlite-shm")
			
			let didCopySHM: Bool
			do {
				try NSFileManager.defaultManager()
					.copyItemAtURL(seededSHMURL!, toURL: shmURL)
				didCopySHM = true
			} catch let error as NSError {
				fileManagerError = error
				didCopySHM = false
			}
			if !didCopySHM {
				print("Error seeding Core Data: \(fileManagerError)")
				abort()
			}
			
			// 5
			fileManagerError = nil
			let walURL = documentsURL.URLByAppendingPathComponent(
				"FourCharactersDatabase.sqlite-wal")
			let seededWALURL = bundle
				.URLForResource("FourCharactersDatabase",
					withExtension: "sqlite-wal")
			
			let didCopyWAL: Bool
			do {
				try NSFileManager.defaultManager()
					.copyItemAtURL(seededWALURL!, toURL: walURL)
				didCopyWAL = true
			} catch let error as NSError {
				fileManagerError = error
				didCopyWAL = false
			}
			if !didCopyWAL {
				print("Error seeding Core Data: \(fileManagerError)")
				abort()
			}
			
			print("Seeded Core Data")
		}
		
		// 6
		var error: NSError? = nil
		let options = [NSInferMappingModelAutomaticallyOption:true,
			NSMigratePersistentStoresAutomaticallyOption:true]
		do {
			store = try psc.addPersistentStoreWithType(NSSQLiteStoreType,
				configuration: nil,
				URL: storeURL,
				options: options)
		} catch let error1 as NSError {
			error = error1
			store = nil
		}
		
		// 7
		if store == nil {
			print("Error adding persistent store: \(error)")
			abort()
		}
	}
	
	func applicationDocumentsDirectory() -> NSURL {
  
		let fileManager = NSFileManager.defaultManager()
  
		let urls =
		fileManager.URLsForDirectory(.DocumentDirectory,
			inDomains: .UserDomainMask) as [NSURL]
  
		return urls[0]
	}
	
	//	func saveContext() {
	//		context.performBlock { () -> Void in
	//			var error: NSError? = nil
	//			if self.context.hasChanges && !self.context.save() {
	//				print("Could not save: \(error), \(error?.userInfo)")
	//				abort()
	//			}
	//		}
	//}
	
}


