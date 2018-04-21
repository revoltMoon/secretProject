//
//  favouriteTableViewController.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit

class favouriteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! favouriteTableViewCell
        cell.favCourseName?.text = "meow"
        cell.favCourseName?.textColor = UIColor(displayP3Red: 0, green: 100, blue: 0, alpha: 0.5)
        cell.backgroundColor = UIColor(displayP3Red: 0, green: 150, blue: 0, alpha: 0.2)
        cell.favCourseImage?.backgroundColor = UIColor(displayP3Red: 0, green: 50, blue: 0, alpha: 0.2)
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
