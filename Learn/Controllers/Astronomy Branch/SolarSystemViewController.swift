//
//  ViewController.swift
//  Learn

import UIKit
import SceneKit
import ARKit

class SolarSystemViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var planetDetailText: UITextView!
    @IBOutlet var tapRec: UITapGestureRecognizer!
    
    var center :CGPoint?    // Point declared for nodal detection
    var solarSystemAssetsPath = "art.scnassets/SolarSystem/PlanetTextures/" //Textures and Assets Path
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create the whole Solar System AR model {Function}
        createSolarSystem()
        
        // Enable Auto lightning
        sceneView.autoenablesDefaultLighting = true
        
        // Provide a background milkyway image to the scene
//        sceneView.scene.background.contents = UIImage(named: "art.scnassets/milky.jpg")!
        
        // Create and add a tap gesture recognizer to the scene
        tapRec = UITapGestureRecognizer(target: self, action: #selector(SolarSystemViewController.handleTap(_:)))
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
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // Function that creates the solar system
    func createSolarSystem() {

        // Parent Node
        let parentNode = SCNNode()
        parentNode.position.z = -5
        
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        let mercury = Planet(name: "Mercury", radius: 0.10, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIImage(named: "\(solarSystemAssetsPath)mercury.jpg")!, distanceFromSun: 1.5, desc: "s")
        
        let venus = Planet(name: "Venus", radius: 0.2, rotation: CGFloat(GLKMathDegreesToRadians(18)), texture: UIImage(named: "\(solarSystemAssetsPath)venus.jpg")!, distanceFromSun: 2, desc: "s")
        
        let earth = Planet(name: "Earth", radius: 0.25, rotation: CGFloat(GLKMathDegreesToRadians(16)), texture: UIImage(named: "\(solarSystemAssetsPath)earth.jpg")!, distanceFromSun: 2.5, desc: "s")
        
        let mars = Planet(name: "Mars", radius: 0.15, rotation: CGFloat(GLKMathDegreesToRadians(2)), texture: UIImage(named: "\(solarSystemAssetsPath)mars.jpg")!, distanceFromSun: 3, desc: "s")
        
        let jupiter = Planet(name: "Jupiter", radius: 0.40, rotation: CGFloat(GLKMathDegreesToRadians(5)), texture: UIImage(named: "\(solarSystemAssetsPath)jupiter.jpg")!, distanceFromSun: 4, desc: "s")

        let saturn = Planet(name: "Saturn", radius: 0.45, rotation: CGFloat(GLKMathDegreesToRadians(9)), texture: UIImage(named: "\(solarSystemAssetsPath)saturn.jpg")!, distanceFromSun: 6, desc: "s")

        let uranus = Planet(name: "Uranus", radius: 0.35, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIImage(named: "\(solarSystemAssetsPath)uranus.jpg")!, distanceFromSun: 7, desc: "s")

        let neptune = Planet(name: "Neptune", radius: 0.3, rotation: CGFloat(GLKMathDegreesToRadians(13)), texture: UIImage(named: "\(solarSystemAssetsPath)neptune.jpg")!, distanceFromSun: 8, desc: "s")

        let pluto = Planet(name: "Pluto", radius: 0.17, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIImage(named: "\(solarSystemAssetsPath)pluto.jpg")!, distanceFromSun: 8.5, desc: "s")
        
        // The Sun and SunFlare animation
        let Sun = Planet(name: "Sun", radius: 0.5, rotation: CGFloat(5), texture: UIImage(named: "\(solarSystemAssetsPath)sun.jpg")!, distanceFromSun: 0, desc: "s")
        
        let SunFlare = SCNParticleSystem(named: "sunFlare.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(SunFlare)
        
        // Add planets to Array for ease of use
        let planets = [Sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
        
        // Create Planet nodes and add to Parent Node
        for planet in planets {
            parentNode.addChildNode(createNode(from: planet))
        }
        
        // Light
//        let light = SCNLight()
//        light.type = .omni
//        let lightNode = SCNNode()
//        lightNode.light = light
//        lightNode.position.y = 3
//        parentNode.addChildNode(lightNode)
//        parentNode.light = light
        
        // Star particles
        let stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(stars)
        
        sceneView.scene.rootNode.addChildNode(parentNode)
        
    }
    
    // Function that creates a Text node for planet from name and applies given texture
    func createTextNode(from planet: SCNNode, texture: UIImage) -> SCNNode {
        
        let textGeometry = SCNText(string: "\(planet.name ?? "no name")", extrusionDepth: 1.0)
        
        textGeometry.firstMaterial?.diffuse.contents = texture//UIImage(named: planet.texture)
        
        let textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = planet.position
        textNode.position.y = planet.position.y + 0.5
        textNode.scale = SCNVector3(0.04, 0.04, 0.04)
        
        return textNode
    }
    
    // Function that creates a node from planet
    func createNode(from planet: Planet) -> SCNNode {
        
        // Create a parent node which will hold bith text and planet together
        let parentNode = SCNNode()
        
        // Create a spherical geometry node and apply texture
        let sphereGeometry = SCNSphere(radius: planet.radius)
        sphereGeometry.firstMaterial?.diffuse.contents = planet.texture
        
        // Create a node to contain a planet inside the spherical geometry
        let planetNode = SCNNode(geometry: sphereGeometry)
        planetNode.position.z = -planet.distanceFromSun
        
        planetNode.name = planet.name
        
        // Add planet to parent node
        parentNode.addChildNode(planetNode)
     
        // Add rings of Saturn to Saturn Planet node
        if planet.name == "Saturn" {
            let ringGeometry = SCNTube(innerRadius: 0.5, outerRadius: 0.7, height: 0.02)
            ringGeometry.firstMaterial?.diffuse.contents = UIImage(named:"\(solarSystemAssetsPath)saturn-ring.jpg")
            
            let ringNode = SCNNode(geometry: ringGeometry)
            ringNode.eulerAngles.x = Float(-20.degToRad)
            planetNode.addChildNode(ringNode)
        }
        
        // Add Text Node (name of planet) with the same texture as of the planet to parent node
        parentNode.addChildNode(createTextNode(from: planetNode,texture: planet.texture))
        
        // Add axial rotation
//        let axisRotateAction = SCNAction.rotate(by: .pi/2, around: SCNVector3(0,1,0), duration: 1)
//        planetNode.runAction(.repeatForever(axisRotateAction))
        
        // Add orbital rotation and particle trace of orbit to all planets except the Sun and add action to parent node
        if planet.name != "Sun"{
            
            // Particle Trace
            let planetOrbitLine = SCNParticleSystem(named: "planetOrbit.scnp", inDirectory: nil)!
            planetOrbitLine.particleColor = UIColor.darkGray
            planetNode.addParticleSystem(planetOrbitLine)
            
            // Planet y axes positioning
            if planet.name == "Mercury"{planetNode.position.y = -0.1}
            else if planet.name == "Venus"{planetNode.position.y = -0.2}
            else if planet.name == "Earth"{planetNode.position.y = 0.2}
            else if planet.name == "Mars"{planetNode.position.y = 0.2}
            else if planet.name == "Jupiter"{planetNode.position.y = -0.3}
            else if planet.name == "Saturn"{planetNode.position.y = -0.3}
            else if planet.name == "Uranus"{planetNode.position.y = 0.3}
            else if planet.name == "Neptune"{planetNode.position.y = 0.4}
            else if planet.name == "Pluto"{planetNode.position.y = -0.4}
            
            // Orbital rotation
            let rotateAction = SCNAction.rotateBy(x: 0, y:planet.rotation , z:0 , duration: 1)
            parentNode.runAction(.repeatForever(rotateAction))
        }
        
        return parentNode
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    // Override to create and configure nodes for anchors added to the view's session.
/*    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
//    func checkIfNodeDetectedInFrustumOfCameraView() {
//
//        guard let cameraPointOfView = sceneView.pointOfView  else {return}
//
//        for node in nodesRendered{
//
//            if sceneView.isNode(node, insideFrustumOf: cameraPointOfView) {
//                print("\(node.childNodes.first?.name ?? "Yes Name") Is in view of the Camera")
////                planetDetailText.text = node.childNodes.first?.name
//            }
////            else {
////                print("None of the planets are in view of the Camera")
////            }
//        }
//
//
//    }
//
//    // Check if scene rendered in any possibel way (for nodal detection)
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//
//        checkIfNodeDetectedInFrustumOfCameraView()
//
//    }
    
    // Function detects a node via the hitTest in the center of the screen with a CGPoint
    func detectNode() -> String {
        
        let sceneHitTest = sceneView.hitTest(center!, options: nil)
        guard let hitNode = sceneHitTest.last?.node else {return "No name found!"}
        return hitNode.name ?? "No name to return"
        
    }
    
    // Function to check every frame change
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        let planetName = detectNode()

        // DispatchQueue for threading and multi-threaded pooling
        DispatchQueue.main.async {
            if (planetName != "No name found!" && planetName != "No name to return"){
                self.setPlanetDetailText(planetName)
            }
        }
        
        // Debug
//        print(planetName + "\(center!.x,center!.y)")
        
    }
    
    //  Funciton as Tap Gesture Recognizer Handler
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
//        let results = self.sceneView.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)
//        guard let _: ARHitTestResult = results.first else {return}
        
        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
    
        if !tappedNode.isEmpty {
            let node = tappedNode[0].node
        
            // DispatchQueue for threading and multi-threaded pooling
            DispatchQueue.main.async {
                if (node.name != "No name found!" && node.name != "No name to return"){
                    self.setPlanetDetailText(node.name!)
                }
            }
        }
    }

    // Function that sets the Info pane text
    func setPlanetDetailText(_ info: String){
        var desc = ""
        
        switch info {
        case "Mercury":
            desc = info+"\nThe closest planet to the Sun, Mercury is only a bit larger than Earth's moon. Its day side is scorched by the Sun and can reach 840 degrees Fahrenheit (450 Celsius), but on the night side, temperatures drop to hundreds of degrees below freezing. Mercury has virtually no atmosphere to absorb meteor impacts, so its surface is pockmarked with craters, just like the moon. Over its four-year mission, NASA's MESSENGER spacecraft has revealed views of the planet that have challenged astronomers' expectations.\nDiscovery: Known to the ancients and visible to the naked eye\nNamed for: Messenger of the Roman gods\nDiameter: 3,031 miles (4,878 km)\nOrbit: 88 Earth days\nDay: 58.6 Earth days"
        case "Venus":
            desc = info+"\nThe second planet from the sun, Venus is terribly hot, even hotter than Mercury. The atmosphere is toxic. The pressure at the surface would crush and kill you. Scientists describe Venus’ situation as a runaway greenhouse effect. Its size and structure are similar to Earth, Venus' thick, toxic atmosphere traps heat in a runaway greenhouse effect. Oddly, Venus spins slowly in the opposite direction of most planets.\nThe Greeks believed Venus was two different objects — one in the morning sky and another in the evening. Because it is often brighter than any other object in the sky — except for the sun and moon — Venus has generated many UFO reports.\nDiscovery: Known to the ancients and visible to the naked eye\nNamed for: Roman goddess of love and beauty\nDiameter: 7,521 miles (12,104 km)\nOrbit: 225 Earth days\nDay: 241 Earth days"
        case "Earth":
            desc = info+
            """
            \n The third planet from the sun, Earth is a waterworld, with two-thirds of the planet covered by ocean. It’s the only world known to harbor life. Earth’s atmosphere is rich in life-sustaining nitrogen and oxygen. The imaginary line on which it rotates is called Orbit.
            \n                        Rotation                         \n
            The Earth spins, just like a top, on its axis in an anticlockwise direction. This movement is called rotation. The rotation of Earth on its axis causes day and night. At any time, only half is in shadow. The Earth takes 24 hours to rotate once on its axis. Earth's surface rotates about its axis at 1,532 feet per second (467 meters per second) — slightly more than 1,000 mph (1,600 kph) — at the equator.
            
            \n                        Revolution                         \n
            As the Earth spins on its axis, it also moves around the Sun. This movement is called revolution. Revolution is a movement in which an object moves around another object. The Earth revolves around the Sun, and the Moon revolves around the Earth in a fixed path, called an orbit. The Earth completes one orbit around the Sun in approximately 365 days. This period is called a year. The year is divided up into the four seasons we call spring, winter, fall and summer.
            
            """
            
            
        case "Mars":
            desc = info+"\nThe fourth planet from the sun, is a cold, dusty place. The dust, an iron oxide, gives the planet its reddish cast. Mars shares similarities with Earth: It is rocky, has mountains and valleys, and storm systems ranging from localized tornado-like dust devils to planet-engulfing dust storms. It snows on Mars. And Mars harbors water ice. Scientists think it was once wet and warm, though today it’s cold and desert-like.\nMars' atmosphere is too thin for liquid water to exist on the surface for any length of time. Scientists think ancient Mars would have had the conditions to support life, and there is hope that signs of past life — possibly even present biology — may exist on the Red Planet.\nDiscovery: Known to the ancients and visible to the naked eye\nNamed for: Roman god of war\nDiameter: 4,217 miles (6,787 km)\nOrbit: 687 Earth days\nDay: Just more than one Earth day (24 hours, 37 minutes)"
        case "Jupiter":
            desc = info+"\nThe fifth planet from the sun, Jupiter is huge and is the most massive planet in our solar system. It’s a mostly gaseous world, mostly hydrogen and helium. Its swirling clouds are colorful due to different types of trace gases. A big feature is the Great Red Spot, a giant storm which has raged for hundreds of years. Jupiter has a strong magnetic field, and with dozens of moons, it looks a bit like a miniature solar system.\nDiscovery: Known to the ancients and visible to the naked eye\nNamed for: Ruler of the Roman gods\nDiameter: 86,881 miles (139,822 km)\nOrbit: 11.9 Earth years\nDay: 9.8 Earth hours"
        case "Saturn":
            desc = info+"\nThe sixth planet from the sun is known most for its rings. When Galileo Galilei first studied Saturn in the early 1600s, he thought it was an object with three parts. Not knowing he was seeing a planet with rings, the stumped astronomer entered a small drawing — a symbol with one large circle and two smaller ones — in his notebook, as a noun in a sentence describing his discovery. More than 40 years later, Christiaan Huygens proposed that they were rings. The rings are made of ice and rock. Scientists are not yet sure how they formed. The gaseous planet is mostly hydrogen and helium. It has numerous moons.\nDiscovery: Known to the ancients and visible to the naked eye\nNamed for: Roman god of agriculture\nDiameter: 74,900 miles (120,500 km)\nOrbit: 29.5 Earth years\nDay: About 10.5 Earth hours"
        case "Uranus":
            desc = "\nThe seventh planet from the sun, Uranus is an oddball. It’s the only giant planet whose equator is nearly at right angles to its orbit — it basically orbits on its side. Astronomers think the planet collided with some other planet-size object long ago, causing the tilt. The tilt causes extreme seasons that last 20-plus years, and the sun beats down on one pole or the other for 84 Earth-years. Uranus is about the same size as Neptune. Methane in the atmosphere gives Uranus its blue-green tint. It has numerous moons and faint rings.\nDiscovery: 1781 by William Herschel (was thought previously to be a star)\nNamed for: Personification of heaven in ancient myth\nDiameter: 31,763 miles (51,120 km)\nOrbit: 84 Earth years\nDay: 18 Earth hours"
        case "Neptune":
            desc = info+"\nThe eighth planet from the sun, Neptune is known for strong winds — sometimes faster than the speed of sound. Neptune is far out and cold. The planet is more than 30 times as far from the sun as Earth. It has a rocky core. Neptune was the first planet to be predicted to exist by using math, before it was detected. Irregularities in the orbit of Uranus led French astronomer Alexis Bouvard to suggest some other might be exerting a gravitational tug. German astronomer Johann Galle used calculations to help find Neptune in a telescope. Neptune is about 17 times as massive as Earth.\nDiscovery: 1846\nNamed for: Roman god of water\nDiameter: 30,775 miles (49,530 km)\nOrbit: 165 Earth years\nDay: 19 Earth hours"
        case "Pluto":
            desc = info+"(Dwarf Planet)\nOnce the ninth planet from the sun, Pluto is unlike other planets in many respects. It is smaller than Earth's moon. Its orbit carries it inside the orbit of Neptune and then way out beyond that orbit. From 1979 until early 1999, Pluto had actually been the eighth planet from the sun. Then, on Feb. 11, 1999, it crossed Neptune's path and once again became the solar system's most distant planet — until it was demoted to dwarf planet status. Pluto will stay beyond Neptune for 228 years. Pluto’s orbit is tilted to the main plane of the solar system — where the other planets orbit — by 17.1 degrees. It’s a cold, rocky world with only a very ephemeral atmosphere. NASA's New Horizons mission performed history's first flyby of the Pluto system on July 14, 2015.\nDiscovery: 1930 by Clyde Tombaugh\nNamed for: Roman god of the underworld, Hades\nDiameter: 1,430 miles (2,301 km)\nOrbit: 248 Earth years\nDay: 6.4 Earth day"
        case "Sun":
            desc = info + " AGE : 4.5 Billin Years" + "Facts about the Sun : The Sun accounts for 99.86% of the mass in the solar system. It has a mass of around 330,000 times that of Earth. It is three quarters hydrogen and most of its remaining mass is helium."
            + " The Sun—the heart of our solar system—is a yellow dwarf star, a hot ball of glowing gases. Its gravity holds the solar system together, keeping everything from the biggest planets to the smallest particles of debris in its orbit. Electric currents in the Sun generate a magnetic field that is carried out through the solar system by the solar wind—a stream of electrically charged gas blowing outward from the Sun in all directions."
        default:
            break
        }
        planetDetailText.text = desc
    }
    
}

// Extension that converts an Integer to CGFloat and multiplies with pi [for degree to radians]
extension Int {
    var degToRad: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
