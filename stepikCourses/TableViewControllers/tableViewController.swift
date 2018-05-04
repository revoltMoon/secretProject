//
//  ViewController.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import UIKit
import CoreData
class tableViewController: UITableViewController, UISearchResultsUpdating, stepikDel {
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCourses = [String]()                       //courses after filtration
    var coursesNamesAndImages = [String:UIImage]()         //for the moment, when we will start filtrating courses(needed Img from this dict)
    var coursesInMemory: [NSManagedObject] = []            //This for courses from memory
    var favCourses = [String:UIImage]()                    //for courses, which we would like to make favourite
    var coursesName = [String]()                           //names of courses from server
    var imgArr = [UIImage]()                               //images of courses from server
    var stepik: stepikServer?                              //Stepik class for server operations
    var ourPage = 1                                         //first page for downloading from server
    var isSearching = false                                 //searchMode
    var mem: Memory?                                        //Memory class for CoreData operations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepik = stepikServer()
        stepik?.delegate = self
        stepik?.getCourse(ourPage: ourPage)
        mem = Memory()
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
        
        //setup our button
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(tableViewController.favPressed(sender:)), for: .touchUpInside)
        
        
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
        //это позволит нам убрать проверку isSearching при нажатии на кнопку, так как будем брать из этого массива данные
        if !isSearching {
            filteredCourses = coursesName
        }
    }
    //get course images from server
    func getImage(array: [UIImage]) {
        for item in array{
        self.imgArr.append(item)
        }
        if ourPage < 5 {
            ourPage += 1
            stepik?.getCourse(ourPage: ourPage)
        }
        self.addImgAndNameInDict()
        self.tableView.reloadData()
    }
    
    //this method helps us to add pairs (NameOfCourse,Image) to the Dictionary
    func addImgAndNameInDict() {
        if !imgArr.isEmpty && !coursesName.isEmpty{
        for idx in 0...imgArr.count-1 {
            coursesNamesAndImages.updateValue(imgArr[idx], forKey: coursesName[idx])
        }
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
    
    
    //введена непревзойденная защита от очень быстрого тыканья по кнопке добавить в избранное
    //а вообще, метод нужен для того, чтобы добавлять в память избранные курсы(картинку + название курса)
    //суть проверок основывается на том, что мы проверяем, есть ли в CoreData уже избранный курс, если нет, добавляем
    @objc func favPressed(sender: UIButton){
            var coursesNamesFromMem = [String]()
            if !coursesInMemory.isEmpty && !favCourses.keys.contains(filteredCourses[sender.tag]){
            for i in 0...coursesInMemory.count-1{
                let nameOfCourse = coursesInMemory[i].value(forKeyPath: "courseName") as? String
                coursesNamesFromMem.append(nameOfCourse!)
            }
                if !coursesNamesFromMem.contains(filteredCourses[sender.tag]){
                    favCourses.updateValue(coursesNamesAndImages[filteredCourses[sender.tag]]!, forKey: filteredCourses[sender.tag])
                    let data = UIImagePNGRepresentation(coursesNamesAndImages[filteredCourses[sender.tag]]!) as Data?
                    mem?.saveYourCourse(name: filteredCourses[sender.tag], imgData: data!)
                }
                
            } else if !favCourses.keys.contains(filteredCourses[sender.tag]) {
                favCourses.updateValue(coursesNamesAndImages[filteredCourses[sender.tag]]!, forKey: filteredCourses[sender.tag])
                let data = UIImagePNGRepresentation(coursesNamesAndImages[filteredCourses[sender.tag]]!) as Data?
                mem?.saveYourCourse(name: filteredCourses[sender.tag], imgData: data!)
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coursesInMemory = mem!.takeYourMemory()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

