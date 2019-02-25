//
//  BotanyARSceneController.swift
//  Learn
//
//  Created by Shiza Siddique on 2/13/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import QuickLook


class BotanyARSceneController: UIViewController, ARSCNViewDelegate {
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var botanyDetailText: UITextView!
    
    var modelName: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        sceneView.autoenablesDefaultLighting = true
        
        sceneView.allowsCameraControl = true
        //        tapRec = UITapGestureRecognizer(target: self, action: #selector(SolarSystemViewController.handleTap(_:)))
        //        sceneView.addGestureRecognizer(tapRec)
        
        print("Botany AR \(modelName!)")
        createModel(modelName: "\(modelName!)")
        setBodyDetailText("\(modelName!)")
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func backToModels(_ sender: Any) {
        let modelSelectionController = storyboard?.instantiateViewController(withIdentifier: "PlantStructureViewController")
        navigationController?.pushViewController(modelSelectionController!, animated: true)
        
    }
    
    func createModel(modelName: String) {
        
        if let modelScene = SCNScene(named: "art.scnassets/Botany/Models/\(modelName).scn") {
            
            if let modelNode = modelScene.rootNode.childNodes.first {
                if modelName == "Flowers"{
                    modelNode.position.z = -20.0
                    print("MAKING FLOWER")
                    //                    modelNode.position.y = -2.0
//                    modelNode.name = modelName
//                    sceneView.scene = modelScene
                }
                else if modelName == "Lilies"{
                    modelNode.position.z = -20.0
//                    modelNode.name = modelName
//                    sceneView.scene = modelScene
                }
                
                
                modelNode.name = modelName
                sceneView.scene = modelScene
            }
        }
        
    }
    
    func setBodyDetailText(_ info: String){
        var desc = ""
        
        switch info {
        case "Flower":
            desc = info + "Flower blahh blahhhhhhhhhh"
            break
        case "lilies":
            desc = info + "Water lilies blahh blahhhhh"
            break
        default:
            break
        }
        
        botanyDetailText.text = desc
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
    
}
