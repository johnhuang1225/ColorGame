//
//  Record+CoreDataProperties.swift
//  ColorGame
//
//  Created by John Huang on 2016/1/12.
//  Copyright © 2016年 JohnHuang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Record {

    @NSManaged var name: String?
    @NSManaged var score: String?

}
