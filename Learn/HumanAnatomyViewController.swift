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
        setBodyDetailText("\(modelName!)")
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
        
        if let modelScene = SCNScene(named: "art.scnassets/HumanAnatomy/AnatomyModels/\(modelName).scn") {
            
            if let modelNode = modelScene.rootNode.childNodes.first {
                if modelName == "Body"{
                    modelNode.position.z = -15.0
                    modelNode.position.y = -2.0
                }
                else if modelName == "Muscle"{
                    modelNode.position.z = -20.0
                }
                else if modelName == "Eyes"{
                    modelNode.position.z = -10.0
                }
                else{
                    modelNode.position.z = -1.5
                }
                
                modelNode.name = modelName
                sceneView.scene = modelScene
            }
        }
        
    }
    
    
    
    // Function that sets the Info pane text
    func setBodyDetailText(_ info: String){
        var desc = ""
        
        switch info {
        case "Heart":
            desc = info+" Heart is located a little to the left of the middle of your chest, and it's about the size of your fist. The heart sends blood around your body. The blood provides your body with the oxygen and nutrients it needs. It also carries away waste. Your heart is sort of like a pump, or two pumps in one. The right side of your heart receives blood from the body and pumps it to the lungs. The left side of the heart does the exact opposite: It receives blood from the lungs and pumps it out to the body."
            break
        case "Body":
            desc = info+"You have five digits on each hand and each foot, making 10 fingers and 10 toes altogether. Each bit of our body is made up from cells, which are the tiniest form of life – like single Lego pieces. The parts of our body need blood in order to work properly – blood transports the nutrients each cell needs, and takes away any rubbish. Parts of your arm include your hand, wrist and elbow.Parts of your leg include your foot, ankle, shin and thigh. The parts of your body that help your arms twist around are called shoulders – your legs are attached to hips. Your neck allows your head to move from side to side, so you can turn your face to look at something. Your stomach sits inside your body, just below your chest and lungs, and above your intestines. Parts of your face include your forehead, eyes, cheeks, ears, nose and mouth."
            break
        case "Muscle":
            desc = info + "The human body has more than 600 muscles. They do everything from pumping blood throughout the body to helping us lift something heavy. Skeletal muscles are voluntary muscles, which means you can control what they do. Your leg won't bend to kick the soccer ball unless you want it to. "
            break
        case "Eyes":
             desc = info+"Your eyes are at work from the moment you wake up to the moment you close them to go to sleep. They take in tons of information about the world around you — shapes, colors, movements, and more. Then they send the information to your brain for processing so the brain knows what's going on outside of your body. The eye is about as big as a ping-pong ball and sits in a little hollow area (the eye socket) in the skull. The eyelid protects the front part of the eye. The lid helps keep the eye clean and moist by opening and shutting several times a minute. The white part of the eyeball is made of a tough material and has the important job of covering most of the eyeball. "
            break
        case "Brain":
            desc = info+"The brain is the control centre for your body and it sits in your skull at the top of your spinal cord. Your brain is more powerful, more complex and more clever than any computer ever built. It gets the messages from your senses - seeing, hearing, tasting, smelling, touching and moving. The messages travel from nerve cells all over the body. They travel along nerve fibres to nerve cells in the brain.\n" + "Fun Facts:  The left side of your brain is usually better at problem solving, maths and writing. The right side of the brain is creative and helps you to be good at art or music."
            break
            
        default:
            break
            
        }
        
        
        planetDetailText.text = desc
        
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

