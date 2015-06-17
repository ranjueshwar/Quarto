//
//  DataManager.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import CoreData

public class DataManager: NSObject {
	
	public class func getContext() -> NSManagedObjectContext {
			return CoreDataStack.coreDataStackInstance.context
	}
	
	public class func deleteManagedObject(object:NSManagedObject) {
		getContext().deleteObject(object)
		saveManagedContext()
	}
	
	public class func saveManagedContext() {
		var error: NSErrorPointer!
		if !getContext().save(error){
			
			NSLog("Unresolved error saving context \(error)")
			
		}
		
	}
	
	
}
