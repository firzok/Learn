//
//  BotanyDetectionViewController.swift
//  Learn
//
//  Created by Faateh Jarree on 2/16/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import ARKit

class BotanyDetectionViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet var tapRec: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/myScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.autoenablesDefaultLighting = true
        
        // Create and add a tap gesture recognizer to the scene
        tapRec = UITapGestureRecognizer(target: self, action: #selector(BotanyDetectionViewController.handleTap(_:)))
        sceneView.addGestureRecognizer(tapRec)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        guard let ref = ARReferenceObject.referenceObjects(inGroupNamed: "FlowerObjects", bundle: Bundle.main) else {
            fatalError("Missing")
        }
        
        configuration.detectionObjects = ref
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
//        print("inside Renderer function, outside if let")
        
        if let objectAnchor = anchor as? ARObjectAnchor {
            let plane = SCNPlane(width: CGFloat(objectAnchor.referenceObject.extent.x), height: CGFloat(objectAnchor.referenceObject.extent.y))
            
            plane.cornerRadius = plane.width / 8
            
            let spriteKitScene = SKScene(fileNamed: "PlantInfo")
            plane.firstMaterial?.diffuse.contents = spriteKitScene
            plane.firstMaterial?.isDoubleSided = true
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.2, objectAnchor.referenceObject.center.z)
            
            node.addChildNode(planeNode)
            
//            node.scale = SCNVector3(0.25,0.25,0)
        
            
            let axisRotateAction = SCNAction.rotate(by: .pi/2, around: SCNVector3(0,1,0), duration: 2)
            node.runAction(.repeatForever(axisRotateAction))
            
        }
        
        return node
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
        
        if !tappedNode.isEmpty {
            let node = tappedNode[0].node
            let zoomAction = SCNAction.scale(to: 2, duration: 3)
            node.runAction(zoomAction)
        }
    }
    
}
