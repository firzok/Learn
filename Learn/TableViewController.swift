//
//  TableViewController.swift
//  Learn
//
//  Created by Faateh Jarree on 11/20/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import Foundation
import UIKit


var PlanetList = ["Mercury","Venus","Earth","Mars","Jupiter","Uranus","Saturn","Pluto","Solar System"]

var PlanetIndex = 0

class TableViewController: UITableViewController{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (PlanetList.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = PlanetList[indexPath.row]
        
        return (cell)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        PlanetIndex = indexPath.row
        print(PlanetList)
        performSegue(withIdentifier: "tablesegue", sender: self)
    }
    
    
    
    
    
    
}
