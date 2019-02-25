//
//  BotanySelectionViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 2/13/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation
import UIKit

class BotanySelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var gifImage: UIImageView!
    let botanyModelNames = ["Flower","lilies"]
    var thumbnails = [UIImage] ()
    var thumbnailIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        gifImage.loadGif(name: "botanyGif")
        collectionView.reloadData()
        
        for model in botanyModelNames{
            if let thumbnail = UIImage(named: "art.scnassets/Botany/thumbnails/\(model).jpg"){
                thumbnails.append(thumbnail)
            }
        }
    }
    @IBAction func backToModel(_ sender: UIButton) {
//        print("INSIDE BACK BTN")
        let modelSelectionController = storyboard?.instantiateViewController(withIdentifier: "ModelSelectViewController")
        navigationController?.pushViewController(modelSelectionController!, animated: true)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BotanyARSceneController
        destinationVC.modelName = "\(sender.unsafelyUnwrapped)"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return botanyModelNames.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BotanyCollectionViewCell
        
        if let cell = cell {
            
            cell.modelThumbnail.image = thumbnails[indexPath.item]
            let title = botanyModelNames[indexPath.item]
            cell.modelName.text = title.capitalized
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ArViewSegue", sender: botanyModelNames[indexPath.item])
    }
    
}


