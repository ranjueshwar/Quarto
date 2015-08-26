//
//  InterfaceController.swift
//  Quarto WatchKit Extension
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import WatchKit
import Foundation
import QFrameworkWatch

class InterfaceController: WKInterfaceController {
	
	@IBOutlet weak var playButton: WKInterfaceButton!
	var WordsArr:[QWord]!
	
	override func awakeWithContext(context: AnyObject?) {
	
		super.awakeWithContext(context)
	}
	
	override func willActivate() {
		// This method is called when watch view controller is about to be visible to user
		setData()
		super.willActivate()
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
	}
	
	func setData(){
		let fcCoreDataService = FCCoreDataService()
		WordsArr = fcCoreDataService.getWords(fcCoreDataService.getRandomNumbersArray(1, upperLimit: 1372, batchSize: 50), context: nil)
		FCGameScoreService().resetGameScore()
	}
	
	@IBAction func playButtonTapped() {
		InterfaceController.reloadRootControllersWithNames(["MAIN_GAME"], contexts: [WordsArr])
	}
	
}
