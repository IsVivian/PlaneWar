//
//  EnemyPlane.swift
//  PlaneWar
//
//  Created by sherry on 16/9/9.
//  Copyright © 2016年 sherry. All rights reserved.
//

import SpriteKit

enum EnemyPlaneType:Int{
    case small = 0
    case medium = 1
    case large = 2
}

class EnemyPlane: SKSpriteNode {

    var hp: Int = 5
    var type: EnemyPlaneType = .small
    
    class func createSmallPlane() -> EnemyPlane {
    
        let planeTexture = SKTexture(imageNamed: "enemy1_fly_1")
        let plane = EnemyPlane(texture: planeTexture)
        plane.hp = 1
        plane.type = EnemyPlaneType.small
        plane.setScale(0.5)
        plane.physicsBody = SKPhysicsBody(rectangleOf: plane.size)
        
        return plane
    
    }
    
    class func createMediumPlane() -> EnemyPlane {
    
        let planeTexture = SKTexture(imageNamed: "enemy3_fly_1")
        let plane = EnemyPlane(texture: planeTexture)
        plane.hp = 5
        plane.type = EnemyPlaneType.medium
        plane.setScale(0.5)
        plane.physicsBody = SKPhysicsBody(texture: planeTexture, size: plane.size)
        
        return plane
        
    }
    
    class func createLargePlane() -> EnemyPlane {
    
        let planeTexture = SKTexture(imageNamed: "enemy2_fly_1")
        let plane = EnemyPlane(texture: planeTexture)
        plane.hp = 7
        plane.type = EnemyPlaneType.large
        plane.setScale(0.5)
        plane.physicsBody = SKPhysicsBody(texture: planeTexture, size: plane.size)
        
        return plane

    }
    
}
