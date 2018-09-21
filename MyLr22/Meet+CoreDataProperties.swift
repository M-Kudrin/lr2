//
//  Meet+CoreDataProperties.swift
//  MyLr22
//
//  Created by Admin on 24.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Meet {

    @NSManaged var date: NSDate?
    @NSManaged var desc: String?
    @NSManaged var isVisited: NSNumber?
    @NSManaged var name: String?
    @NSManaged var category: Category?
    
    func addCategory(value:Category){
        self.setValue(value, forKey: "category")
    }

}
