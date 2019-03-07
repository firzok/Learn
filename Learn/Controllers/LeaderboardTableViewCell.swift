//
//  LeaderboardTableViewCell.swift
//  Learn
//
//  Created by Shiza Siddique on 3/4/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LeaderboardTableViewCell{
    
    func setCollectionViewDataSourceDelegate
        <D:UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate:D , forRow row:Int){
        
        collectionViewCell.delegate = dataSourceDelegate
        collectionViewCell.dataSource = dataSourceDelegate
        
        
        collectionViewCell.reloadData()
    }
    
}
