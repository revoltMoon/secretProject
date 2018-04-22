//
//  ViewController.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController, ololo, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredCourses = [String]()
    var coursesName = [String]()
    var imgArr = [UIImage]()
    var stepik: stepikServer?
    var ourPage = 1
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        stepik = stepikServer()
        stepik?.delegate = self
        stepik?.getCourse(int: ourPage)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filteredCourses.count
        }
        return coursesName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tableViewCell
        if !coursesName.isEmpty {
            if isSearching {
                cell.courseName?.text = filteredCourses[indexPath.row]
            } else {
                cell.courseName?.text = coursesName[indexPath.row]
            }
//        cell.courseName?.text = coursesName[indexPath.row]
        cell.courseName?.textColor = UIColor(displayP3Red: 0, green: 0, blue: 100, alpha: 0.5)
        cell.backgroundColor = UIColor(displayP3Red: 150, green: 0, blue: 100, alpha: 0.2)
        cell.courseImage?.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 50, alpha: 0.2)
            if isSearching {
                
            } else {
                
            }
            if !imgArr.isEmpty {
                if imgArr[indexPath.row].isEqual(nil) || coursesName.count > imgArr.count{
                    self.imgArr.append(UIImage(named: "NotFound.png")!)
                }
                if isSearching {
                    
                }
//                cell.courseImage?.image = scaleImage(img: imgArr[indexPath.row])
            }
        }
        return cell
    }
    
    func scaleImage(img: UIImage) -> UIImage {
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 90, height: 90), true, scale)
        img.draw(in: CGRect(origin: .zero, size: CGSize(width: 90, height: 90)))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getNames(array: [String]) {
        for item in array{
            self.coursesName.append(item)
            self.tableView.reloadData()
        }
    }
    
    func getImage(array: [UIImage]) {
        for item in array{
        self.imgArr.append(item)
        }
        if ourPage < 5 {
            ourPage += 1
            stepik?.getCourse(int: ourPage)
        }
        self.tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
//            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredCourses = coursesName.filter({$0.contains(searchBar.text!)})
            tableView.reloadData()
        }
    }
}
