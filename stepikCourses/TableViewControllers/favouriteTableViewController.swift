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
    var mem: Memory?                                //Memory class for CoreData operations
    var favCourses = [String:UIImage]()             //Dictionary for favourite courses
    var coursesInMemory: [NSManagedObject] = []     //This for courses from memory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mem = Memory()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coursesInMemory = mem!.takeYourMemory()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
