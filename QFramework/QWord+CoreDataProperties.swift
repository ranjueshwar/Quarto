//
//  QWord+CoreDataProperties.swift
//  Quarto
//
//  Created by Prathap Murthy on 01/07/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

public extension QWord {

    @NSManaged public var charactersList: String
    @NSManaged public var length: Int16
    @NSManaged public var wordId: Int32
    @NSManaged public var wordSet: Set<String>

}
