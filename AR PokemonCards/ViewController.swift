//
//  ViewController.swift
//  AR PokemonCards
//
//  Created by Krishna Ajmeri on 9/16/19.
//  Copyright © 2019 Krishna Ajmeri. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
	
	//MARK: - Variable Declaration
	
	@IBOutlet var sceneView: ARSCNView!
	let node = SCNNode()
	
	//MARK: - View Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sceneView.delegate = self
		sceneView.autoenablesDefaultLighting = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARImageTrackingConfiguration()
		if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
			configuration.trackingImages = imagesToTrack
			configuration.maximumNumberOfTrackedImages = 5
			
			print("Images successfully added")
		}
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
	}
	
	//MARK: - Touch/Motion Methods
	
	
	//MARK: - Image Rendering Methods
	
	
	
	//MARK: - ARSCNViewDelegate Methods
	
	func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
		if let imageAnchor = anchor as? ARImageAnchor {
			createPlane(withImageAnchor: imageAnchor)
		}
		
		return node
	}
	
	//MARK: - Plane Rendering Methods
	
	func createPlane(withImageAnchor imageAnchor: ARImageAnchor) {
		let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
		let planeNode = SCNNode(geometry: plane)
		
		plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
		
		planeNode.eulerAngles.x = -.pi / 2
		
		node.addChildNode(planeNode)
		
		if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
			if let pokeNode = pokeScene.rootNode.childNodes.first {
				pokeNode.eulerAngles.x = .pi / 2
				planeNode.addChildNode(pokeNode)
			}
			
		}
	}
}
