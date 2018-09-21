//
//  Category+CoreDataProperties.swift
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

extension Category {

    @NSManaged var name: String?
    @NSManaged var meets: NSSet?
    
    func addMeet(value:Meet){
        
        let list = self.mutableSetValueForKey("meets")
        
        list.addObject(value)
    }

}
