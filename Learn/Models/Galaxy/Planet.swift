//
//  Planet.swift
//  Learn
//
//  Created by Faateh Jarree on 11/10/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit

class Planet {
    var name : String
    var radius : CGFloat
    var rotation : CGFloat
    var texture : String
    var distanceFromSun : Float
 
    // Initializer
    init(name : String, radius : CGFloat, rotation : CGFloat, texture : String, distanceFromSun : Float) {
        self.name = name
        self.radius = radius
        self.rotation = rotation
        self.texture = texture
        self.distanceFromSun = distanceFromSun
    }
}
