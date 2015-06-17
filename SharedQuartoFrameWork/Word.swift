//
//  Word.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import CoreData

public class Word: NSManagedObject {

    @NSManaged public var charactersList: String
    @NSManaged public var length: Int16
    @NSManaged public var wordId: Int32
    @NSManaged public var wordSet: AnyObject

}
