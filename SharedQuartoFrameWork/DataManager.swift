//
//  DataManager.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import CoreData

public class DataManager: NSObject {
	
	public enum DataManagerContextType : UInt {
		case PrivateQueueConcurrencyType
		case MainQueueConcurrencyType
	}
	
	public class func getContext( ctxtType: DataManagerContextType = DataManagerContextType.MainQueueConcurrencyType) -> NSManagedObjectContext {
		if ctxtType == DataManagerContextType.PrivateQueueConcurrencyType {
			return CoreDataStack.coreDataStackInstance.getPrivateContext()
		} else {
			return CoreDataStack.coreDataStackInstance.context
		}
	}

//	public func deleteManagedObject(object:NSManagedObject) {
//		getContext().deleteObject(object)
//		saveManagedContext()
//	}
//	
//	public func saveManagedContext() {
//		
//		do {
//			try getContext().save()
//		} catch {
//				NSLog("Unresolved error saving context \(error)")
//		}
	
	//}
	
	
}
