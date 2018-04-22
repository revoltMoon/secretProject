//
//  favouriteTableViewController.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit
import CoreData

class favouriteTableViewController: UITableViewController {
    var favCourses = [String:UIImage]()
    var tableV: tableViewController?
    var coursesInMemory: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV = tableViewController()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesInMemory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! favouriteTableViewCell
        let course = coursesInMemory[indexPath.row]
        cell.favCourseName.text = course.value(forKeyPath: "courseName") as? String
        cell.favCourseName?.textColor = UIColor(displayP3Red: 0, green: 0.3, blue: 0, alpha: 0.5)
        cell.backgroundColor = UIColor(displayP3Red: 0, green: 0.6, blue: 0, alpha: 0.2)
        let img: Data = course.value(forKey: "courseImg")! as! Data
        let decodedImg = UIImage(data: img)
        cell.favCourseImage?.image = decodedImg
        return cell
    }
    
    
    func save(name: String, imgData: Data) {
        
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
            coursesInMemory.append(course)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
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
        self.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
