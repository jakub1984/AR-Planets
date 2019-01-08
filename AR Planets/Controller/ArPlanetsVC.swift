//
//  ViewController.swift
//  AR Planets
//
//  Created by Jakub Perich on 06/01/2019.
//  Copyright © 2019 Jakub Perich. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ArPlanetsVC: UIViewController, ARSCNViewDelegate {
   
    var passedPlanet : String!
    let baseNode = SCNNode()
    let planetNode = SCNNode()
    let textNode = SCNNode()
    let shipNode = SCNNode()

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        addBaseNode()
        addPlanet()
        addPlanetLabel()
        addShip()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        sceneView.addGestureRecognizer(gesture)
        
    }
    
    func addBaseNode() {
        baseNode.position = SCNVector3(0.0, 0.0, -1.5)
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    func addPlanet() {
        let planet = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: passedPlanet)
        planet.materials = [material]
        planetNode.geometry = planet
        baseNode.addChildNode(planetNode)
        
//        let planetRotation = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 10)
//        let infiniteRotation = SCNAction.repeatForever(planetRotation)
//        let's make it one line:
        let planetRotation = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 25))
        
        planetNode.runAction(planetRotation)
    }
    
    func addPlanetLabel() {
        let text = SCNText(string: passedPlanet.capitalized, extrusionDepth: 1)
        text.font = UIFont(name: "futura", size: 30)
        text.flatness = 0
        let scaleFactor = 0.1 / text.font.pointSize
        
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        textNode.geometry = text

        let min = textNode.boundingBox.min.x
        let max = textNode.boundingBox.max.x
        let midpoint = -((max - min) / 2 + min) * Float(scaleFactor)
        
        textNode.position = SCNVector3(midpoint, 0.35, 0)
        baseNode.addChildNode(textNode)
        
    }
    
    func addShip() {
        let orbitAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 8))
        let shipUpAction = SCNAction.move(to: SCNVector3(-0.35, 0.15, 0), duration: 2)
        let wait = SCNAction.wait(duration: 2)
        let levelOff = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 2.5)
        let shipDownAction = SCNAction.move(to: SCNVector3(-0.35, -0.15, 0), duration: 2)
        let upAndDownAction = SCNAction.sequence([shipUpAction, wait, shipDownAction, wait])
        let repeatUpAndDown = SCNAction.repeatForever(upAndDownAction)
        let shipPitchUp = SCNAction.rotateBy(x: -0.5, y: 0, z: -0.17, duration: 1.5)
        let shipPitchDown = SCNAction.rotateBy(x: 0.5, y: 0, z: 0.17, duration: 1.5)
        let pitchUpAndDown = SCNAction.sequence([shipPitchUp, levelOff, shipPitchDown, levelOff])
        let rotateAndPitchRepeat = SCNAction.repeatForever(pitchUpAndDown)
        
        
        
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")
            if let shipNode = scene?.rootNode.childNode(withName: "ship", recursively: true) {
            shipNode.scale = SCNVector3(0.2, 0.2, 0.2)
            shipNode.position = SCNVector3(-0.4, 0, 0)
            baseNode.addChildNode(shipNode)
            let rotateNode = SCNNode()
            baseNode.addChildNode(rotateNode)
            rotateNode.addChildNode(shipNode)
            rotateNode.runAction(orbitAction)
            shipNode.runAction(repeatUpAndDown)
            shipNode.runAction(rotateAndPitchRepeat)
            }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            dismiss(animated: false, completion: nil)
        }
    }
    
    
    
}
