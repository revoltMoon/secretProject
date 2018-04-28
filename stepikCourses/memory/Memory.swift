//
//  Memory.swift
//  stepikCourses
//
//  Created by Влад Купряков on 28.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit
import CoreData
class Memory {
    func takeYourMemory() -> [NSManagedObject] {
        var coursesInMemory: [NSManagedObject] = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return coursesInMemory
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Courses")
        do {
            coursesInMemory = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return coursesInMemory
    }
    
    func saveYourCourse(name: String, imgData: Data) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Courses", in: managedContext)!
        let course = NSManagedObject(entity: entity,  insertInto: managedContext)
        course.setValue(name, forKeyPath: "courseName")
        course.setValue(imgData, forKey: "courseImg")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
