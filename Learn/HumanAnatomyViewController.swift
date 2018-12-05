//
//  HumanAnatomyViewController.swift
//  Learn
//
//  Created by Faateh Jarree on 12/4/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import QuickLook

class HumanAnatomyViewController: UIViewController, ARSCNViewDelegate {
   
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet var tapRec: UITapGestureRecognizer!
    @IBOutlet weak var planetDetailText: UITextView!
    
    var modelName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
        sceneView.allowsCameraControl = true
//        tapRec = UITapGestureRecognizer(target: self, action: #selector(SolarSystemViewController.handleTap(_:)))
//        sceneView.addGestureRecognizer(tapRec)
        createModel(modelName: "\(modelName!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Automatic Texuturing for surrounding occlusion on Body Model
        configuration.environmentTexturing = .automatic
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func createModel(modelName: String) {
        
        if let modelScene = SCNScene(named: "art.scnassets/AnatomyModels/\(modelName).scn") {
            
            if let modelNode = modelScene.rootNode.childNodes.first {
                
                modelNode.position.z = -0.5
                modelNode.name = modelName
                sceneView.scene = modelScene
            }
        }
        
    }
    
//    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
//
//        let results = self.sceneView.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)
//        guard let _: ARHitTestResult = results.first else {return}
//
//        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
//
//        if !tappedNode.isEmpty {
//            let node = tappedNode[0].node
//
//            // DispatchQueue for threading and multi-threaded pooling
//            DispatchQueue.main.async {
//                if (node.name != "No name found!" && node.name != "No name to return"){
//                    self.setPlanetDetailText(node.name!)
//                }
//            }
//
//            // Debug
//            //            print(node.name ?? "Not a node")
//        }
//    }
//
//    // Function that sets the Info pane text
//    func setPlanetDetailText(_ info: String){
//        planetDetailText.text = info
//    }
    
}

