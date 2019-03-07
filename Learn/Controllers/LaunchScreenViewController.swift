//
//  LaunchScreenViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 3/7/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var launchGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        launchGif.loadGif(name: "launchScreen")

    }
    


}
