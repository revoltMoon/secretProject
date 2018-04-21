//
//  ViewController.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController, ololo {
    var coursesName = [String]()
    var coursesImgDict = [String:String]()
    var imgArr = [UIImage]()
    var stepik: stepikServer?
    override func viewDidLoad() {
        super.viewDidLoad()
        stepik = stepikServer()
        stepik?.delegate = self
        stepik?.getCourse()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tableViewCell
        if !coursesName.isEmpty{
        cell.courseName?.text = coursesName[indexPath.row]
        cell.courseName?.textColor = UIColor(displayP3Red: 0, green: 0, blue: 100, alpha: 0.5)
        cell.backgroundColor = UIColor(displayP3Red: 150, green: 0, blue: 100, alpha: 0.2)
        cell.courseImage?.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 50, alpha: 0.2)
            if !imgArr.isEmpty{
                cell.courseImage?.image = imgArr[indexPath.row]
            }
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getNames(array: [String]) {
        for item in array{
            coursesName.append(item)
            coursesImgDict.updateValue("", forKey: item)
        }
        self.stepik?.getImages()
    }
    
//    func getImageURL(array: [String]) {
//        for item in array{
//            coursesImgDict.updateValue(item, forKey: coursesName[array.index(of: item)!])
//            self.tableView.reloadData()
//        }
//    }
    
    func getImage(array: [UIImage]) {
        self.imgArr = array
        self.tableView.reloadData()
    }

}

