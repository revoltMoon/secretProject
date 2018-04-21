//
//  stepikServer.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import Foundation
import UIKit
protocol ololo {
    func getNames(array: [String])
//    func getImageURL(array: [String])
    func getImage(array: [UIImage])
}
class stepikServer {
    var delegate: (ololo?) = nil
    var urlImages = [String]()
    func getCourse() {
        var courseNames = [String]()
        var urlImgArr = [UIImage]()
        var urlImgDict = [String:UIImage]()
        let path = "https://stepik.org/api/search-results?page=1"
        let request = URL(string: path)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request!, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                var dic = json!!["search-results"] as? [[String: Any]]
                for info in dic! {
                    if let name  = info["course_title"] as? String {
                        courseNames.append(name)
                    }
                    if let name  = info["course_cover"] as? String {
                        self.urlImages.append(name)
                    }
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    for item in self.urlImages {
                        let dataWithImg = try? Data(contentsOf: URL(string: item)!)
                        urlImgArr.append(UIImage(data: dataWithImg!)!)
                    }
                    DispatchQueue.main.async {
                    self.delegate?.getNames(array: courseNames)
                    self.delegate?.getImage(array: urlImgArr)
                    }
                }
                }
//                DispatchQueue.main.async {
//                self.delegate?.getNames(array: courseNames)
//                    self.delegate?.getImageURL(array: self.urlImages)
//                    for item in self.urlImages {
//                        let dataWithImg = try? Data(contentsOf: URL(string: item)!)
//                        //                    urlImgDict.append(UIImage(data: dataWithImg!)!)
//                        urlImgArr.append(UIImage(data: dataWithImg!)!)
//                    }
//                    self.delegate?.getImage(array: urlImgArr)
//                }
//                DispatchQueue.main.async {
//                    self.delegate?.getImageURL(array: self.urlImages)
//                }
//                DispatchQueue.main.async {
//                    for item in self.urlImages {
//                        let dataWithImg = try? Data(contentsOf: URL(string: item)!)
//                        //                    urlImgDict.append(UIImage(data: dataWithImg!)!)
//                        urlImgArr.append(UIImage(data: dataWithImg!)!)
//                    }
//                    self.delegate?.getImage(array: urlImgArr)
//                }
//            }
        })
        task.resume()
    }
    
    func getImages (){
//        print(self.urlImages)
        let path = "https://stepik.org/api/search-results?page=1"
        let request = URL(string: path)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request!, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
            }
        })
        task.resume()
        
    }
}
