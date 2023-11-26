//
//  GameViewController.swift
//  monkeyGame iOS
//
//  Created by Varun Sharma on 25/11/23.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    @IBOutlet weak var scnView: SCNView!
    @IBOutlet weak var vc: SCNView!
    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    
    var gameController: GameController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let url = Bundle.main.url(forResource: "CartoonMonkeyModel", withExtension: "obj", subdirectory: "Art")
             else { fatalError("Failed to find model file.") }

        let asset = MDLAsset(url:url)
        
       var object = asset.object(at: 0) as? MDLMesh
            
        

        //let newNode  = SCNNode(mdlObject: object)
        let nnode = SCNNode(mdlobject)
        nnode.mdlobject = object
        
        //gameView.addSubview(CartoonMonkeyModel)
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
