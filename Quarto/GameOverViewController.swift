//
//  GameOverViewController.swift
//  Quarto
//
//  Created by Prathap Murthy on 08/07/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import UIKit
import QFramework

class GameOverViewController: UIViewController {
	
	
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var wordLabel: UILabel!
	@IBOutlet weak var playButton: UIButton!
	
	var score: Int = 0
	var word: String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		print(score)
		print(word)
		scoreLabel.text = String(score)
		wordLabel.text = word
	}
	
	func getWords() -> [QWord]!{
		return FCCoreDataService().getWordsData()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "MainGame2" {
			let controller = segue.destinationViewController
				as! MainGameViewController
			controller.wordsArray = getWords()
		}
	}
	
	@IBAction func playButtonTapped(sender: UIButton!){
		UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2,
			initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
				self.playButton.bounds.size.width += 80.0
			}, completion: {_ in self.setWordsArr()})
		
	}
	
	func setWordsArr(){
		if let wordsArr = getWords() {
			performSegueWithIdentifier("MainGame2", sender: wordsArr)
		} else {
			print("no data")
			abort()
		}
	}

}