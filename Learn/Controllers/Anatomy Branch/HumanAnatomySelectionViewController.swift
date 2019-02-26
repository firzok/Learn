//
//  CollectionViewController.swift
//  Learn
//
//  Created by Faateh Jarree on 12/4/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import QuickLook

class HumanAnatomySelectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var gifImage: UIImageView!
    let models = ["Heart","Body","Brain","Muscle","Eyes","Teeth"]
    var thumbnails = [UIImage] ()
    var thumbnailIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        gifImage.loadGif(name: "anatomyGif")
        collectionView.reloadData()
        
        
        for model in models{
            if let thumbnail = UIImage(named: "art.scnassets/HumanAnatomy/AnatomyThumbnails/\(model).jpg"){
                thumbnails.append(thumbnail)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
        print("PREPARE IS CALLEDDD")
        if segue.identifier == "ArViewSegue" {
            if let destinationVC = segue.destination as? HumanAnatomyViewController {
                print(sender.unsafelyUnwrapped)
                destinationVC.modelName = "\(sender.unsafelyUnwrapped)"
            }
        }
//        let destinationVC = segue.destination as! HumanAnatomyViewController
//        destinationVC.modelName = "\(sender.unsafelyUnwrapped)"
        
    }
    
    
    @IBAction func backToModel(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
//        let modelSelectionController = storyboard?.instantiateViewController(withIdentifier: "ModelSelectViewController")
//        navigationController?.pushViewController(modelSelectionController!, animated: true)
    }
    
//    @IBAction func backToModel(_ sender: UIButton) {
//        let modelSelectionController = storyboard?.instantiateViewController(withIdentifier: "ModelSelectionViewController")
//        navigationController?.pushViewController(modelSelectionController!, animated: true)
//        
//    }
    
    
}

extension HumanAnatomySelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HumanAnatomySelectionViewCell
        
        if let cell = cell {
            cell.modelThumbnail.image = thumbnails[indexPath.item]
            let title = models[indexPath.item]
            cell.modelTitle.text = title.capitalized
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("model name \(models[indexPath.item])")
        
        self.performSegue(withIdentifier: "ArViewSegue", sender: models[indexPath.item])
        
//        thumbnailIndex = indexPath.item
//        let previewController = QLPreviewController()
//        previewController.dataSource = self
//        previewController.delegate = self
//        present(previewController, animated: true)
    }
    
}

//extension HumanAnatomySelectionViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource{
//    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
//        return 1
//    }
//
//    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        print(models[thumbnailIndex])
//        let url = Bundle.main.url(forResource: models[thumbnailIndex], withExtension: "usdz")!
//
//        return url as QLPreviewItem
//    }
//
//
//}

