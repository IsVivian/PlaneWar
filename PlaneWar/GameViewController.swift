//
//  GameViewController.swift
//  PlaneWar
//
//  Created by sherry on 16/9/9.
//  Copyright (c) 2016年 sherry. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {

    class func unarchFromFile(_ file: NSString) -> SKNode? {
        
        let path = Bundle.main.path(forResource: file as String, ofType: "sks")
        
        do {
        
            let sceneData: Data = try Data(contentsOf: URL(fileURLWithPath: path!), options: NSData.ReadingOptions.mappedIfSafe)
        
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            
            return scene
        
        }catch {
        
        }
        
        return nil
        
    }

}

class GameViewController: UIViewController {
    
    var restartButton: UIButton!
    var pauseButton: UIButton!
    var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.size = view.frame.size
            
            skView.presentScene(scene)
            
            initButton()
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "gameOver"), object: nil, queue: OperationQueue.main, using: { (noti) in
                
                let backgroundView = UIView(frame: self.view.bounds)
                self.restartButton.center = backgroundView.center
                self.restartButton.isHidden = false
                backgroundView.addSubview(self.restartButton)
                backgroundView.center = self.view.center
                self.view.addSubview(backgroundView)
                
            })
            
        }
        
    }
    
    func initButton() {
    
        let buttonImage = UIImage(named: "BurstAircraftPause")!
        
        pauseButton = UIButton()
        pauseButton.frame = CGRect(x: 10, y: 25, width: buttonImage.size.width, height: buttonImage.size.height)
        pauseButton.setBackgroundImage(buttonImage, for: UIControlState())
        pauseButton.addTarget(self, action: #selector(pauseAct), for: .touchUpInside)
        self.view.addSubview(pauseButton)
        
        restartButton = UIButton()
        restartButton.bounds = CGRect(x: 0, y: 0, width: 200, height: 30)
        restartButton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2+30)
        restartButton.isHidden = true
        restartButton.setTitle("重新开始", for: UIControlState())
        restartButton.setTitleColor(UIColor.black, for: UIControlState())
        restartButton.layer.borderWidth = 2.0
        restartButton.layer.cornerRadius = 15.0
        restartButton.layer.borderColor = UIColor.gray.cgColor
        restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        self.view.addSubview(restartButton)
        
        continueButton = UIButton()
        continueButton.bounds = CGRect(x: 0, y: 0, width: 200, height: 30)
        continueButton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.height/2-30)
        continueButton.isHidden = true
        continueButton.setTitle("开始游戏", for: UIControlState())
        continueButton.setTitleColor(UIColor.black, for: UIControlState())
        continueButton.layer.borderWidth = 2.0
        continueButton.layer.cornerRadius = 15.0
        continueButton.layer.borderColor = UIColor.gray.cgColor
        continueButton.addTarget(self, action: #selector(continueGame), for: .touchUpInside)
        self.view.addSubview(continueButton)
        
    
    }
    
    //暂停
    func pauseAct() {
    
        (self.view as! SKView).isPaused = true
        restartButton.isHidden = false
        continueButton.isHidden = false
    
    }
    
    //继续
    func restart() {
    
        restartButton.isHidden = true
        continueButton.isHidden = true
        self.becomeFirstResponder()
        (self.view as! SKView).isPaused = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "restart"), object: nil)
    
    }
    
    func continueGame() {
    
        continueButton.isHidden = true
        restartButton.isHidden = true
        (self.view as! SKView).isPaused = false
        
    }

    override var shouldAutorotate : Bool {
        return false
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
