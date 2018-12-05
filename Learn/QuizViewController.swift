//
//  QuizViewController.swift
//  Learn
//
//  Created by Firzok Nadeem on 05/12/2018.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class QuizViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var planetDetailText: UITextView!
    @IBOutlet var tapRec: UITapGestureRecognizer!
    
    var center :CGPoint?    // Point declared for nodal detection

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Enable Auto lightning
        sceneView.autoenablesDefaultLighting = true
        
        // Create and add a tap gesture recognizer to the scene
        tapRec = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.handleTap(_:)))
        sceneView.addGestureRecognizer(tapRec)
        
        // Create a 2d coordinate in the middle of the screen for node detection location
        center = CGPoint(x:sceneView.bounds.midX,y:sceneView.bounds.midY)
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//
//    }
    
    
    
    //  Funciton as Tap Gesture Recognizer Handler
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
   
    }
}
