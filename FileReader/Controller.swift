//
//  Controller.swift
//  FileReader
//
//  Created by Baicheng Chen on 1/9/18.
//  Copyright © 2018 Baicheng Chen. All rights reserved.
//

import Foundation
import UIKit

class Controller:UITableViewController
{
    
    var texts:Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The path is essentially a String
        let path = Bundle.main.path(forResource: "something", ofType: "txt")
        //remove the ! will give the path a Optional() wrap
        //print(path!)
        
        //Using file manager to check if the file exist. This can be skipped...
        let manager = FileManager.default
        
        if((path != nil) && manager.fileExists(atPath: path!))
        {
            do
            {
                let fulltext = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                let segs = fulltext.split(separator: "\n")
                
                for seg in segs{
                    texts.append(String(seg))
                }
                
                print(texts)
            
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        else
        {
            print("not exist")
        }
    }
    //This code is unecessary, because I already set the height of cell in the storyboard to 50. Can be changed
    //The number here has priority
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //treating all the cells as a section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //return how many lines
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    //Make each line the text for label in the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ControllerForCell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! ControllerForCell
        cell.labelForText.text = texts[indexPath.row]
        return cell
    }
    //When clicked on cell, deselect makes the gray disappear
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
