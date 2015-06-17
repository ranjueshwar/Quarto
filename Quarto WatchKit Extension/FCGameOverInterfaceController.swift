//
//  FCGameOverInterfaceController.swift
//  Quarto
//
//  Created by Prathap Murthy on 17/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import WatchKit
import Foundation
import SharedQuartoFrameWork

class FCGameOverInterfaceController: WKInterfaceController {
	
	@IBOutlet weak var word: WKInterfaceLabel!
	@IBOutlet weak var score: WKInterfaceLabel!
	
	
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		let arr = context as? [Dictionary<String,AnyObject>]
		var dict = arr?.first
		var w: AnyObject? = dict?["word"]
		var s: AnyObject? = dict?["score"]
		if let correctWord: AnyObject = w {
			word.setText(String(correctWord as! NSString))
		}
		
		if let currentScore: AnyObject = s {
			score.setText(String(currentScore as! NSString))
		}
		
	}
	
	override func willActivate() {
		super.willActivate()
	}
	
	override func didDeactivate() {
		super.didDeactivate()
	}
	
	
	
}