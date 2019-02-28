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
        
        sceneView.autoenablesDefaultLighting = true
        
        sceneView.allowsCameraControl = true
        //        tapRec = UITapGestureRecognizer(target: self, action: #selector(SolarSystemViewController.handleTap(_:)))
        //        sceneView.addGestureRecognizer(tapRec)
        
        print("Botany AR \(modelName!)")
        createModel(modelName: "\(modelName!)")
        setBodyDetailText("\(modelName!)")
    }
    
    
    func createModel(modelName: String) {
        
        if let modelScene = SCNScene(named: "art.scnassets/Botany/Models/\(modelName).scn") {
            
            if let modelNode = modelScene.rootNode.childNodes.first {
                if modelName == "Flower"{
                    modelNode.position.z = -20.0
                    //                        modelNode.position.y = -2.0
                    //                    modelNode.name = modelName
                    //                    sceneView.scene = modelScene
                }
                else if modelName == "Lilies"{
                    modelNode.position.z = -20.0
                }
                else if modelName == "Ferns"{
                    modelNode.position.z = -5.0
                    modelNode.eulerAngles.x = 40
                }
                else if modelName == "Conifers"{
                    modelNode.position.z = -20.0
                    modelNode.scale.x = 0.04
                    modelNode.scale.y = 0.04
                    modelNode.scale.z = 0.04
                }
                
                
                
                modelNode.name = modelName
                sceneView.scene = modelScene
            }
        }
        
    }
    
    func setBodyDetailText(_ info: String){
        var desc = ""
        
        switch info {
        case "Flowers":
            desc = info + """
            \n Flowers are the reproductive parts of flowering plants. A flower is a special part of the plant. Flowers are also called the bloom or blossom of a plant. Flowers have petals. Inside the part of the flower that has petals are the parts which produce pollen and seeds.\n
            Flowers are an important evolutionary advance made by flowering plants. Some flowers are dependent upon the wind to move pollen between flowers of the same species. Their pollen grains are light-weight. Many others rely on insects or birds to move pollen. Theirs are heavier. The role of flowers is to produce seeds, which are contained in fruit. Fruits and seeds are a means of dispersal. Plants do not move, but wind, animals and birds spread the plants across the landscape.\n
            """
            
        case "Lilies":
            desc = info + """
            \n The Lotus plant is an aquatic perennial.\n
            The plant has its roots firmly in the mud and sends out long stems to which their leaves are attached.\n
            The Lotus flowers, seeds, young leaves and rhizomes are all edible.\n
            Water lilies are rooted in soil in bodies of water, with leaves and flowers floating on or emergent from the surface. The leaves are round, with a radial notch.\n
            
            """
            
        case "Mosses":
            desc = info + """
            \n The second group of simple plants is mosses.\n
            They lack true roots, stem, or leaves. Having no roots, stem or leaves means they lack a transport system known as rhizoids. \n
            Mosses donot absorb water. Instead they anchor themselves in the soil.\n
            Water is absorbed by the whole body of the plant, like a piece of sponge. They need to grow near water so their bodies can absorb water.\n
            They reproduce by spores.
            """
            
        case "Ferns":
            desc = info + """
            \n This group of plants is a little more advanced than algae or mosses.\n
            They possess roots, stem and specialized leaves, called fronds. \n
            Like mosses, they also do not produce seeds, flowers and fruits. Instead, they reproduce by tiny dust-like spores. Their spores grow on the underside of their leaves. \n
            Due to the presence of roots, stem and leaves, they can gro taller than mosses and algae .\n
            They need to grow near moist places because their spores need water or moisture. \n
            """
        
        case "Conifers":
            desc = info + """
            \n The fourth group of plants is conifers, which are also known as Gymnosperms.\n
            Conifers are more advanced than ferns, since they produce seeds. But their seeds are not enclosed in a fruit or flower, as the plants in this group lack flowers and fruits.\n
            They reproduce by their seeds. They have needle-like leaves. Since they have a well-developed vascular system, they can grow tall.\n
            """
       
        
            
            
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
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
