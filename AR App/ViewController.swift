//
//  ViewController.swift
//  AR App
//
//  Created by Zukhruf . on 19/01/2021.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {

    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }

    @IBAction func addCube(_ sender: Any) {
        
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z)
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    @IBAction func addCup(_ sender: Any) {
    
        let cupNode = SCNNode()
        let cc = getCameraCoordinates(sceneView: sceneView)
        cupNode.position = SCNVector3(cc.x, cc.y, cc.z)
        guard let virtualObjectScene = SCNScene(named: "cup.scn", inDirectory: "Models.scnassets/cup") else {
            return
        }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        cupNode.addChildNode(wrapperNode)
        sceneView.scene.rootNode.addChildNode(cupNode)
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
     
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    struct myCameraCoordinate {
        
        var x = Float()
        var y = Float()
        var z = Float()
    }
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinate {
        
        let cameraTrnsform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinate = MDLTransform(matrix: cameraTrnsform!)
        var cc = myCameraCoordinate()
        cc.z = cameraCoordinate.translation.z
        cc.y = cameraCoordinate.translation.y
        cc.x = cameraCoordinate.translation.x
        return cc
    }
}

