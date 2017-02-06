//
//  ViewController.swift
//  ThreadApp2
//
//  Created by Vishwajeet Dagar on 2/1/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var APIlist = ["https://www.makaan.com/petra/data/v1/entity/unit-types","https://www.makaan.com/petra/data/v1/entity/master-amenities","https://www.makaan.com/petra/data/v1/entity/master-furnishings","https://www.makaan.com/petra/data/v1/entity/master-tenant-types","https://www.makaan.com/petra/data/v1/entity/direction","https://www.makaan.com/petra/data/v1/entity/master-ownership-types","https://www.makaan.com/petra/data/v1/entity/master-listing-construction-status","https://www.makaan.com/petra/data/v1/entity/master-specifications","https://www.makaan.com/petra/data/v1/entity/unit-types"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTasks()
    }
    
    func runTasks(){
        
        let taskGroup = DispatchGroup()
        
        for api in APIlist{
                taskGroup.enter()
                DispatchQueue.global(qos: .utility).async {
                NetworkUtil().query(url: URL(string: api)!, networkClosure: {(data :Data?)->() in
                    do{
                        if data != nil {
                            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
                              print(convertedJsonIntoDict)
                            }
                        }
                        taskGroup.leave()
                    }
                    catch let error as NSError {
                        print("Error found\(error.localizedDescription)")
                    }
                })
            }
        }
        
        taskGroup.notify(queue: DispatchQueue.main){
        let alert=UIAlertController(title: "Alert", message: "All tasks completed", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler:nil ))
        self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

