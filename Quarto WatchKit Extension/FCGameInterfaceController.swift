//
//  FCGameInterfaceController.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import WatchKit
import Foundation
import QFrameworkWatch


class FCGameInterfaceContoller: WKInterfaceController {
	
	var isFirstButtonEnabled: Bool = false
	var isSecondButtonEnabled: Bool = false
	var isThirdButtonEnabled: Bool = false
	var isFourthButtonEnabled: Bool = false
	var itemCount: Int = 0
	var words: [QWord]!
	var wordSet: Set<String>!
	var characterArr: [Character]=[]
	var text = String()
	var isWordFound: Bool = false
	var wordsIds: [UInt]!
	var fcGameScoreService: FCGameScoreService = FCGameScoreService()
	var cntDownTimer: NSTimer!
	var Score: Int = 0
	var wordsArray: [QWord]!
	
	@IBOutlet weak var timer: WKInterfaceTimer!
	@IBOutlet weak var userEnteredWord: WKInterfaceLabel!
	@IBOutlet weak var firstLetterButton: WKInterfaceButton!
	@IBOutlet weak var secondLetterButton: WKInterfaceButton!
	@IBOutlet weak var thirdLetterButton: WKInterfaceButton!
	@IBOutlet weak var fourthLetterButton: WKInterfaceButton!
	
	
	override func awakeWithContext(context: AnyObject?) {
		words = context as? [QWord]!
		setLetterTile()
		setDate()
		super.awakeWithContext(context)
	}
	
	override func willActivate() {
		super.willActivate()
		
	}
	
	override func didDeactivate() {
		//fcGameScoreService.setGameScore(Score)
		super.didDeactivate()
	}
	
	func setDate(){
		let startDate = NSDate()
		let calendar = NSCalendar.currentCalendar()
		
		let date = calendar.dateByAddingUnit(NSCalendarUnit.Second, value: 35, toDate: startDate, options: NSCalendarOptions.MatchStrictly)
		if let currentdate = date{
			timer.setDate(currentdate)
		}
		
	}
	
	func showGameOverScreen() {
		WKInterfaceController.reloadRootControllersWithNames(["GAME_OVER"],contexts: [setContext()])
	}
	
	func setLetterTile() {
		let cnt = words.count
		if cnt > 1 {
			let wordModel =  words.removeAtIndex(itemCount)
			self.wordSet = wordModel.wordSet as Set<String>
			let word:String = wordModel.charactersList
			if word != "" {
				var i = 0
				for c in word.characters  {
					i++
					switch i{
					case 1:
						setButtonTitle(firstLetterButton, title: c)
						characterArr.append(c)
					case 2:
						setButtonTitle(secondLetterButton, title: c)
						characterArr.append(c)
					case 3:
						setButtonTitle(thirdLetterButton, title: c)
						characterArr.append(c)
					case 4:
						setButtonTitle(fourthLetterButton, title: c)
						characterArr.append(c)
					default:
						print("invalid character")
					}
				}
			}else{
				print("word is empty")
				stopTimer()
				self.cntDownTimer.invalidate()
			}
		}
	}
	

	
	func setButtonTitle(button: WKInterfaceButton, title: Character){
		button.setTitle(String(title))
	}
	
	@IBAction func firstButtonTap() {
		isFirstButtonEnabled = !isFirstButtonEnabled
		
		if (!isFirstButtonEnabled) {
			removeUserEnteredCharacter(0)
		} else {
			addUserEnteredCharacter(0)
		}
		
	}
	
	@IBAction func secondButtonTap() {
		isSecondButtonEnabled = !isSecondButtonEnabled
		if (!isSecondButtonEnabled) {
			removeUserEnteredCharacter(1)
		} else {
			addUserEnteredCharacter(1)
		}
		
	}
	
	@IBAction func thirdButtonTap() {
		isThirdButtonEnabled = !isThirdButtonEnabled
		if (!isThirdButtonEnabled) {
			removeUserEnteredCharacter(2)
		} else {
			addUserEnteredCharacter(2)
		}
	}
	
	@IBAction func fourthButtonTap() {
		isFourthButtonEnabled = !isFourthButtonEnabled
		if (!isFourthButtonEnabled) {
			removeUserEnteredCharacter(3)
		} else {
			addUserEnteredCharacter(3)
		}
	}
	
	func addUserEnteredCharacter(index: Int) {
		let c:Character = characterArr[index]
		text.append(c)
		updateuserEnteredWord()
	}
	
	func removeUserEnteredCharacter(index: Int) {
		
		let v = String(characterArr[index])
		let range = text.rangeOfString(v)
		text.removeRange(range!)
		
		updateuserEnteredWord()
	}
	
	func updateuserEnteredWord(){
		userEnteredWord.setText(text)
		if text.characters.count == 4  {
			print(self.wordSet)
			isWordFound = getWordFound()
			if isWordFound {
				stopTimer()
				self.cntDownTimer.invalidate()
			}
			createDelay()
		}
	}
	
	func createDelay(){
		_ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "presentWithNewWord", userInfo: nil, repeats: false)
		
	}
	
	func countDownTimer(){
		self.cntDownTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "stopTimer", userInfo: nil, repeats: false)
		
	}
	
	func stopTimer(){
		timer.stop()
		if !self.isWordFound {
			showGameOverScreen()
		}
	}
	
	func presentWithNewWord(){
		if isWordFound {
		updateScore()
		updateTitleWithScore()
		resetButtonsAndFlags()
		setLetterTile()
		setDate()
		startTimer()
		}
	}
	
	func startTimer(){
		timer.start()
		countDownTimer()
	}
	
	func updateScore(){
		Score = ++Score
	}
	
	func updateTitleWithScore(){
		self.setTitle("\(Score)pts")
	}
	
	func getWordFound()-> Bool{
		
		return self.wordSet.contains(text)
		
	}
	
	func setContext()-> AnyObject{
		
		let s: Dictionary<String,AnyObject> = ["score" : Score]
		let w: Dictionary<String,AnyObject> = ["word" : self.wordSet.first!]
		return [w,s]
	}
	
	
	func resetButtonsAndFlags(){
		isFirstButtonEnabled = false
		isSecondButtonEnabled = false
		isThirdButtonEnabled = false
		isFourthButtonEnabled = false
		userEnteredWord.setText("")
		isWordFound = false
		text = String()
		characterArr = [] // Empty array before showing next word
	}
	
}