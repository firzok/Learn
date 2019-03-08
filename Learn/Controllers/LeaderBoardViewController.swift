//
//  LeaderBoardViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 3/6/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderBoardViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate{
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    var thumbnails = [UIImage] ()
    var u1:[String] = []
    
    var positionIndex:IndexPath!
    var gradient:UIColor!
    
    var numberOfChildren:Int?
    
    
    func populateLeaderBoard(){
        self.ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        self.ref!.child("score").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            self.numberOfChildren = Int(snapshot.childrenCount)
            for child in snapshot.children {
                
                
                let snap = child as! DataSnapshot
                
                let name = snap.key
                
                self.u1.append(name)
                
                if let bs = snap.childSnapshot(forPath: "BotanyScore").value! as? NSNumber, let ass = snap.childSnapshot(forPath: "AstronomyScore").value! as? NSNumber, let ans = snap.childSnapshot(forPath: "AnatomyScore").value! as? NSNumber{
                    
                    
                    self.u1.append("\(bs)")
                    self.u1.append("\(ass)")
                    self.u1.append("\(ans)")
                    
                    
                }
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    override func viewDidLoad() {
        
//        populateLeaderBoard()
        
        
        tableView.layer.cornerRadius = 20
        tableView.layer.borderWidth = 3
        tableView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.numberOfChildren ?? 5)+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tablecell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardTableViewCell") as! LeaderboardTableViewCell
        positionIndex = indexPath
        tablecell.contentView.layer.cornerRadius = 8.0
        //        tablecell.contentView.layer.borderWidth = 3.0
        //        tablecell.contentView.layer.borderColor = #colorLiteral(red: 0.266389966, green: 0.2606115639, blue: 0.3600413203, alpha: 1)
        tablecell.contentView.layer.masksToBounds = true
        
        return tablecell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        gradient = colorForIndex(index:indexPath.row)
//        cell.backgroundColor = gradient
    }
    
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = 4
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.4
        //        print("color \(color)")
        return UIColor(red: 0, green: color+0.1, blue: color+0.1, alpha: 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaderboardInsideCollectionViewCell", for: indexPath) as! LeaderboardInsideCollectionViewCell
        cell.informationLabel?.adjustsFontSizeToFitWidth = true
        //        cell.contentView.layer.cornerRadius = 5.0
        //        cell.contentView.layer.borderWidth = 1.0
        //        cell.contentView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //        cell.contentView.layer.masksToBounds = true
        //        cell.layer.masksToBounds = false
        
        if positionIndex.row == 0{
            if indexPath.item == 0{
                cell.informationLabel?.text = "Ranks"
            }
            else if indexPath.item == 1{
                cell.informationLabel?.text = "Users"
            }
            else if indexPath.item == 2{
                cell.informationLabel?.text = "Botany"
            }
            else if indexPath.item == 3{
                
                cell.informationLabel?.text = "Astronomy"
            }
            else if indexPath.item == 4{
                cell.informationLabel?.text = "Anatomy"
            }
            else if indexPath.item == 5{
                cell.informationLabel?.text = "Time Taken"
            }
            
        }
        else{
            if positionIndex.row == 1{
                
                if indexPath.item == 0{
                    cell.positionLabel?.text = String(positionIndex.row)
                    cell.medalImage?.image = #imageLiteral(resourceName: "gold")
                }
            }
            else if positionIndex.row == 2{
                if indexPath.item == 0{
                    cell.positionLabel?.text = String(positionIndex.row)
                    cell.medalImage?.image = #imageLiteral(resourceName: "silver")
                }
            }
            else if positionIndex.row == 3{
                if indexPath.item == 0{
                    cell.positionLabel?.text = String(positionIndex.row)
                    cell.medalImage?.image = #imageLiteral(resourceName: "bronze")
                }
            }
                
            else{
                if indexPath.item == 0{
                    cell.positionLabel?.text = String(positionIndex.row)
                    cell.rankLabel?.text = "Rank"
                }
            }
            
            if indexPath.item == 1{
                cell.informationLabel?.text = u1[5*(positionIndex.row-1)+(indexPath.item-1)]
            }
            else if indexPath.item == 2{
                
                cell.informationLabel?.text = u1[5*(positionIndex.row-1)+(indexPath.item-1)]
            }
            else if indexPath.item == 3{
                
                cell.informationLabel?.text = u1[5*(positionIndex.row-1)+(indexPath.item-1)]
            }
            else if indexPath.item == 4{
                
                cell.informationLabel?.text = u1[5*(positionIndex.row-1)+(indexPath.item-1)]
            }
            else if indexPath.item == 5{
                //            print("sadasd \(indexPath.item)")
                cell.informationLabel?.text = u1[5*(positionIndex.row-1)+(indexPath.item-1)]
            }
        }
        
        return cell
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
