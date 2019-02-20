//
//  CardViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 12/5/18.
//  Copyright © 2018 Mani. All rights reserved.
//
import Foundation
import UIKit

class ModelSelectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    
    let modelNames = ["Astronomy", "Anatomy", "Botany"]
//    let modelImages = [UIImage(named: "Astronomy"),UIImage(named: "Astronomy"),UIImage(named: "Botany")]
    
    var arrayOfIDs = ["SolarSystemView", "HumanAnatomySelectionViewController", "BotanySelectionViewController"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return modelNames.count
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as! ModelSelectionViewCell
//        let textView = cell.viewWithTag(1) as! UILabel
        cell.modelName.text =  modelNames[indexPath.row]
        //        cell.modelImage.image = modelImages[indexPath.row]
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = arrayOfIDs[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController! , animated: true)
        //        let cell = collectionView.cellForItem(at: indexPath)
        //        performSegue(withIdentifier: "showCollectionSegue", sender: self)
        //        PlanetIndex = indexPath.row
        //        print(PlanetList)
        //        performSegue(withIdentifier: "tablesegue", sender: self)
    }
}
