//
//  stepikServer.swift
//  stepikCourses
//
//  Created by Влад Купряков on 21.04.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

import Foundation
import UIKit
protocol stepikDel {
    func getNames(array: [String])
    func getImage(array: [UIImage])
}
class stepikServer {
    var delegate: (stepikDel?) = nil
    func getCourse(int: Int) {
        var courseNames = [String]()
        var urlImgArr = [UIImage]()
        var urlImages = [String]()
        let path = "https://stepik.org/api/search-results?page=\(int)"
        let request = URL(string: path)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request!, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let dic = json!!["search-results"] as? [[String: Any]] {
                    for info in dic {
                    if let name  = info["course_title"] as? String {
                        courseNames.append(name)
                    }
                    
                    if let name  = info["course_cover"] as? String {
                            urlImages.append(name)
                        }
                    }
                }
                                DispatchQueue.global(qos: .userInitiated).async {
                                    for item in urlImages {
                                        if let dataWithImg = try? Data(contentsOf: URL(string: item)!){
                                            urlImgArr.append(UIImage(data: dataWithImg)!)
                                        }
                                    }
                            DispatchQueue.main.async {
                            self.delegate?.getNames(array: courseNames)
                            self.delegate?.getImage(array: urlImgArr)
                            }
                        }
                    }
                })
            task.resume()
        }
    }
