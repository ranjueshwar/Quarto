//
//  FCGameInterfaceController.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

//
//  FCGameInterfaceContoller.swift
//  FourCharacters
//
//  Created by Prathap Murthy on 04/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//
import WatchKit
import Foundation
import SharedQuartoFrameWork


class FCGameInterfaceContoller: WKInterfaceController {
	
	
	var isFirstButtonEnabled: Bool = true
	var isSecondButtonEnabled: Bool = true
	var isThirdButtonEnabled: Bool = true
	var isFourthButtonEnabled: Bool = true
	var itemCount: Int = 0
	var words: [SharedQuartoFrameWork.Word]!
	var wordSet: Set<String>!
	var characters: [Character]=[]
	var text = String()
	var isWordFound: Bool = false
	var wordsIds: [UInt]!
	var fcGameScoreService: FCGameScoreService = FCGameScoreService()
	var cntDownTimer: NSTimer!
	@IBOutlet weak var timer: WKInterfaceTimer!
	@IBOutlet weak var userEnteredWord: WKInterfaceLabel!
	@IBOutlet weak var firstLetterButton: WKInterfaceButton!
	@IBOutlet weak var secondLetterButton: WKInterfaceButton!
	@IBOutlet weak var thirdLetterButton: WKInterfaceButton!
	@IBOutlet weak var fourthLetterButton: WKInterfaceButton!
	
	
	
	override func awakeWithContext(context: AnyObject?) {
		print("awake with context")
		words = context as? [SharedQuartoFrameWork.Word]!
		setLetterTile()
		setDate()

		super.awakeWithContext(context)
	}
	
	override func willActivate() {
		print("will activate")
		// This method is called when watch view controller is about to be visible to user
		timer.start()
		countDownTimer()
		super.willActivate()
		
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
		print("deact")
	}
	
	func setDate(){
		let startDate = NSDate()		
		let calendar = NSCalendar.currentCalendar()
		let date = calendar.dateByAddingUnit(.CalendarUnitSecond, value: 15, toDate: startDate, options: nil)
		if let currentdate = date{
			timer.setDate(currentdate)
		}
		
	}
	
	func showGameOverScreen() {
		WKInterfaceController.reloadRootControllersWithNames(["GAME_OVER"],contexts: [setContext()])
	}
	
	func setLetterTile() {
		itemCount = itemCount+1
		let wordModel = words.removeAtIndex(itemCount)
		self.wordSet = wordModel.wordSet as! Set<String>
		let word:String = wordModel.charactersList
		var i = 0
		for c in word  {
			i++
			switch i{
			case 1:
				setButtonTitle(firstLetterButton, title: c)
				characters.append(c)
			case 2:
				setButtonTitle(secondLetterButton, title: c)
				characters.append(c)
			case 3:
				setButtonTitle(thirdLetterButton, title: c)
				characters.append(c)
			case 4:
				setButtonTitle(fourthLetterButton, title: c)
				characters.append(c)
			default:
				print("invalid charachter")
			}
		}
	}
	
	func setButtonTitle(button: WKInterfaceButton, title: Character){
		button.setTitle(String(title))
	}
	
	@IBAction func firstButtonTap() {
		var alpha: CGFloat = 1
		if (!isFirstButtonEnabled) {
			isFirstButtonEnabled = true
			removeUserEnteredCharacter(0)
		} else {
			addUserEnteredCharacter(0)
			isFirstButtonEnabled = false
			alpha = 0.6
		}
		firstLetterButton.setAlpha(alpha)
		
	}
	
	@IBAction func secondButtonTap() {
		var alpha: CGFloat = 1
		if (!isSecondButtonEnabled) {
			isSecondButtonEnabled = true
			removeUserEnteredCharacter(1)
		} else {
			addUserEnteredCharacter(1)
			isSecondButtonEnabled = false
			alpha = 0.6
		}
		secondLetterButton.setAlpha(alpha)
	}
	
	@IBAction func thirdButtonTap() {
		var alpha: CGFloat = 1
		if (!isThirdButtonEnabled) {
			isThirdButtonEnabled = true
			removeUserEnteredCharacter(2)
		} else {
			addUserEnteredCharacter(2)
			isThirdButtonEnabled = false
			alpha = 0.6
		}
		thirdLetterButton.setAlpha(alpha)
	}
	
	@IBAction func fourthButtonTap() {
		var alpha: CGFloat = 1
		if (!isFourthButtonEnabled) {
			isFourthButtonEnabled = true
			removeUserEnteredCharacter(3)
		} else {
			addUserEnteredCharacter(3)
			isFourthButtonEnabled = false
			alpha = 0.6
		}
		fourthLetterButton.setAlpha(alpha)
	}
	
	func addUserEnteredCharacter(index: Int) {
		let c:Character = characters[index]
		text.append(c)
		updateuserEnteredWord()
	}
	
	func removeUserEnteredCharacter(index: Int) {
		
		let v = String(characters[index])
		let range = text.rangeOfString(v)
		text.removeRange(range!)
		
		updateuserEnteredWord()
	}
	
	func updateuserEnteredWord(){
		userEnteredWord.setText(text)
		if count(text) == 4  {
			print(self.wordSet)
			getWordFound()
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
			setLetterTile()
			resetAlpha()
			userEnteredWord.setText("")
			setDate()
			timer.start()
			countDownTimer()
//			WKInterfaceController.reloadRootControllersWithNames(["MAIN_GAME"], contexts: [words])
		}
	}
	
	func updateScore(){
		fcGameScoreService.updateGameScoreandHighestScore()
	}
	func getWordFound(){
		for w in self.wordSet{
			if w == text {
				print(w)
				isWordFound = true
			}
		}
	}
	
	func setContext()-> AnyObject{
		
		var s: Dictionary<String,AnyObject> = ["score" : self.fcGameScoreService.getScore()]
		print("Score --- \(self.fcGameScoreService.getScore())")
		var w: Dictionary<String,AnyObject> = ["word" : self.wordSet.first!]
		return [w,s]
	}
	
	func resetAlpha(){
		
		firstLetterButton.setAlpha(1)
		secondLetterButton.setAlpha(1)
		thirdLetterButton.setAlpha(1)
		fourthLetterButton.setAlpha(1)
	}
	
}