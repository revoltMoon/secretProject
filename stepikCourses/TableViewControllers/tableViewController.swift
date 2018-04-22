//
//  ViewController.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController, ololo, UISearchResultsUpdating {
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCourses = [String]()                       //courses after filtration
    var coursesNamesAndImages = [String:UIImage]()         //for moment, when we will start filtrating courses(needed Img from this dict)
    var coursesName = [String]()                           //names of courses from server
    var imgArr = [UIImage]()                               //images of courses from server
    var stepik: stepikServer?
    var ourPage = 1
    var isSearching = false                                 //searchMode
    override func viewDidLoad() {
        super.viewDidLoad()
        stepik = stepikServer()
        stepik?.delegate = self
        stepik?.getCourse(int: ourPage)
        self.searchContr()
    }
    //setup our searchController
    func searchContr() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
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
            cell.courseName?.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0.4, alpha: 0.5)
            cell.backgroundColor = UIColor(displayP3Red: 0.6, green: 0, blue: 0.5, alpha: 0.2)
            
            
                //adding an image
                if !imgArr.isEmpty {
                if imgArr[indexPath.row].isEqual(nil) || coursesName.count > imgArr.count{
                    //проверка, если у нас нет картинки для конкретного имени
                    self.imgArr.append(UIImage(named: "NotFound.png")!)
                }
                if isSearching {
                    cell.courseImage?.image = scaleImage(img: (coursesNamesAndImages[filteredCourses[indexPath.row]])!)
                } else {
                    cell.courseImage?.image = scaleImage(img: imgArr[indexPath.row])
                }
            }
        }
        return cell
    }
    //resising images to 90x90
    func scaleImage(img: UIImage) -> UIImage {
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 90, height: 90), true, scale)
        img.draw(in: CGRect(origin: .zero, size: CGSize(width: 90, height: 90)))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    //get course names from server
    func getNames(array: [String]) {
        for item in array{
            self.coursesName.append(item)
            self.tableView.reloadData()
        }
        
    }
    //get course images from server
    func getImage(array: [UIImage]) {
        for item in array{
        self.imgArr.append(item)
        }
        if ourPage < 5 {
            ourPage += 1
            stepik?.getCourse(int: ourPage)
        }
        self.addImgAndNameInDict()
        self.tableView.reloadData()
    }
    
    //this method helps us to add pairs (NameOfCourse,Image) to the Dictionary
    func addImgAndNameInDict() {
        for idx in 0...imgArr.count-1 {
            //проверка, если у нас нет картинки для конкретного имени
            if coursesName.count > imgArr.count {
                self.imgArr.append(UIImage(named: "NotFound.png")!)
            }
            coursesNamesAndImages.updateValue(imgArr[idx], forKey: coursesName[idx])
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            isSearching = true
            filteredCourses = coursesName.filter { name in
                self.coursesNamesAndImages.updateValue(self.imgArr[coursesName.index(of: name)!], forKey: name)
                return name.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            isSearching = false
            filteredCourses = coursesName
        }
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
