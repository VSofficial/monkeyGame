//
//  GameViewController.swift
//  monkeyGame iOS
//
//  Created by Varun Sharma on 25/11/23.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "Art.scnassets/CartoonMonkeyModel", withExtension: "obj") else {
            print("not found")
            return }
        let scene = try? SCNScene(url: url, options: nil)

        if let objectNode = scene?.rootNode.childNode(withName: "CartoonMonkeyModel", recursively: true) {
            // Adjust the position, scale, or other properties of the node if needed
            objectNode.position = SCNVector3(x: 0, y: 0, z: -2) // Example position
            objectNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1) // Example scale
            
            // Add the node to your SceneKit view's scene
           // gameView.scene!.rootNode.addChildNode(objectNode)
            
            // Create an SCNView
         //   let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 300, height: 300)) // Adjust frame size as needed
            // Set the scene to your view
          //  sceneView.scene = scene
            // Add the SCNView to your view hierarchy
         //   self.view.addSubview(sceneView)
            
         //   sceneView.pointOfView = gameView.pointOfView

        }

        //gameView.scene = scene
        
       // self.view.addSubview(gameView)
        self.gameController = GameController(sceneRenderer: gameView)
        
        // Allow the user to manipulate the camera
        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = UIColor.black
        
        // Add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        var gestureRecognizers = gameView.gestureRecognizers ?? []
        gestureRecognizers.insert(tapGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
    }
    
    @objc
    func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        // Highlight the tapped nodes
        let p = gestureRecognizer.location(in: gameView)
        gameController.highlightNodes(atPoint: p)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
