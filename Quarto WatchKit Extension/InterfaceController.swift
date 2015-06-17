//
//  InterfaceController.swift
//  Quarto WatchKit Extension
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import WatchKit
import Foundation
import SharedQuartoFrameWork

class InterfaceController: WKInterfaceController {
	
	@IBOutlet weak var playButton: WKInterfaceButton!
	var WordsArr:[SharedQuartoFrameWork.Word]!
	
	override func awakeWithContext(context: AnyObject?) {
		println("awc")
		super.awakeWithContext(context)
		
		// Configure interface objects here.
	}
	
	override func willActivate() {
		// This method is called when watch view controller is about to be visible to user
	
		super.willActivate()
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
	}
	
	func setData(){
		var fcCoreDataService = FCCoreDataService()
		WordsArr = fcCoreDataService.getWords(fcCoreDataService.getRandomNumbersArray(1, upperLimit: 1372, batchSize: 500))
		FCGameScoreService().resetGameScore()
	}
	
	@IBAction func playButtonTapped() {
		setData()
		InterfaceController.reloadRootControllersWithNames(["MAIN_GAME"], contexts: [WordsArr])
	}
}
