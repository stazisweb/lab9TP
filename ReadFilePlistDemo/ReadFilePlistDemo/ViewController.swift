//
//  ViewController.swift
//  ReadFilePlistDemo
//
//  Created by Anton Sheremet on 6/2/18.
//  Copyright © 2018 Anton Sheremet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myItemKey = "myItem"
    var myItemValue: String?

    @IBOutlet weak var txtValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("myData.plist")
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: "myData", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle file myData.plist is -> \(result?.description)")
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("copy failure.")
                }
            }else{
                print("myData.plist already exists at path.")
            }
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("load myData.plist is -> \(resultDictionary?.description)")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict{
            myItemValue = dict.object(forKey: myItemKey) as! String?
            txtValue.text = myItemValue
        }else{
            print("load failure.")
        }
    }
}

