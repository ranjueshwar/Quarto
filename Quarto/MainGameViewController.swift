//
//  MainGameViewController.swift
//  Quarto
//
//  Created by Prathap Murthy on 30/06/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import UIKit
import QFramework
import AVFoundation

class MainGameViewController: UIViewController {
	
	@IBOutlet weak var mainStackView: UIStackView!
	@IBOutlet weak var topStackView: UIStackView!
	@IBOutlet weak var bottomStackView: UIStackView!
	@IBOutlet weak var labelStackView: UIStackView!
	@IBOutlet weak var rightStackView: UIStackView!
	@IBOutlet weak var leftStackView: UIStackView!
	@IBOutlet weak var staticProgressBar: UIView!
	@IBOutlet weak var firstLetterButton: UIButton!
	@IBOutlet weak var secondLetterButton: UIButton!
	@IBOutlet weak var thirdLetterButton: UIButton!
	@IBOutlet weak var fourthLetterButton: UIButton!
	@IBOutlet weak var firstLetterLabel: UILabel!
	@IBOutlet weak var secondLetterLabel: UILabel!
	@IBOutlet weak var thirdLetterLabel: UILabel!
	@IBOutlet weak var fourthLetterLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var progressBar: UIView!
	
	
	var wordsArray: [QWord] = []
	var wordSet: Set<String> = []
	var charList: String = ""
	var isFirstButtonEnabled: Bool = false
	var isSecondButtonEnabled: Bool = false
	var isThirdButtonEnabled: Bool = false
	var isFourthButtonEnabled: Bool = false
	var isMenuTapped: Bool = false
	var userEnteredString = ""
	var timer: NSTimer!
	var progressBarWidth: CGFloat = 0.0
	var score: Int = 0
	var av: AudioHelper!
	

	
	override func viewDidLoad() {
		
		
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(false)
		av = AudioHelper()
		av.setbuttonBeep()
		getWordFromArray()
		if self.charList != "" {
			setLetterTile(self.charList)
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		self.progressBarWidth = progressBar.bounds.size.width
		updateProgressBar()
	}
	
	override func viewWillDisappear(animated: Bool) {
		let fc = FCGameScoreService()
		fc.setGameScore(score)
		fc.updateGameScoreandHighestScore()
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func getWordFromArray() -> String{
		var wordCnt = wordsArray.count
		let index = --wordCnt
		self.charList = ""
		self.wordSet = Set([])
		if index >= 0  {
			let word = wordsArray.removeLast()
			self.wordSet = word.wordSet
			self.charList = word.charactersList
		}else{
			// TO DO
			print("Fetch more words - include background fetching")
		}
		return self.charList
	}
	
	func isWordFound() -> Bool{
		if self.wordSet.contains(self.userEnteredString){
			return true
		}else{
			return false
		}
	}
	
	func setLetterTile(charList: String){
		var i = 0
		
			for c in charList.characters {
				i++
				switch i{
				case 1:
					setButtonText(String(c),button: firstLetterButton)
					isFirstButtonEnabled = true
				case 2:
					setButtonText(String(c),button: secondLetterButton)
					isSecondButtonEnabled = true
				case 3:
					setButtonText(String(c),button: thirdLetterButton)
					isThirdButtonEnabled = true
				case 4:
					setButtonText(String(c),button: fourthLetterButton)
					isFourthButtonEnabled = true
				default:
					print("no allowed")
				}
			}
		
	}
	
	func setButtonText(title: String, button: UIButton){
		button.setTitle(title, forState: UIControlState.Normal)
	}
	
	@IBAction func firstLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[self.charList.startIndex]
		self.setTappedLabel(text, enabled: isFirstButtonEnabled)
		isFirstButtonEnabled = !isFirstButtonEnabled
		setButtonColor(firstLetterButton, enabled: isFirstButtonEnabled)
		validateWordFound()
		
	}
	
	@IBAction func secondLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[advance(self.charList.startIndex, 1)]
		self.setTappedLabel(text, enabled: isSecondButtonEnabled)
		isSecondButtonEnabled = !isSecondButtonEnabled
		self.setButtonColor(secondLetterButton, enabled: isSecondButtonEnabled)
		validateWordFound()
	}
	
	
	@IBAction func thirdLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[advance(self.charList.startIndex, 2)]
		self.setTappedLabel(text, enabled: isThirdButtonEnabled)
		isThirdButtonEnabled = !isThirdButtonEnabled
		self.setButtonColor(thirdLetterButton, enabled: isThirdButtonEnabled)
		validateWordFound()
	}
	
	
	@IBAction func fourthLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[advance(self.charList.startIndex, 3)]
		self.setTappedLabel(text, enabled: isFourthButtonEnabled)
		isFourthButtonEnabled = !isFourthButtonEnabled
		self.setButtonColor(fourthLetterButton, enabled: isFourthButtonEnabled)
		validateWordFound()
	}
	
	func setTappedLabel (c: Character, enabled: Bool){
		
		if enabled {
			self.userEnteredString.append(c)
		} else {
			let range = self.userEnteredString.rangeOfString(String(c))!
			self.userEnteredString.removeRange(range)
		}
		firstLetterLabel.text = ""
		secondLetterLabel.text = ""
		thirdLetterLabel.text = ""
		fourthLetterLabel.text = ""
		firstLetterLabel.backgroundColor = UIColor.lightGrayColor()
		secondLetterLabel.backgroundColor = UIColor.lightGrayColor()
		thirdLetterLabel.backgroundColor = UIColor.lightGrayColor()
		fourthLetterLabel.backgroundColor = UIColor.lightGrayColor()
		
		if self.userEnteredString.endIndex > self.userEnteredString.startIndex  {
			var i = 0
			for c in self.userEnteredString.characters{
				++i
				switch i{
				case 1:
					firstLetterLabel.text = String(c)
					firstLetterLabel.backgroundColor = UIColor.blueColor()
				case 2:
					secondLetterLabel.text = String(c)
					secondLetterLabel.backgroundColor = UIColor.blueColor()
				case 3:
					thirdLetterLabel.text = String(c)
					thirdLetterLabel.backgroundColor = UIColor.blueColor()
				case 4:
					fourthLetterLabel.text = String(c)
					fourthLetterLabel.backgroundColor = UIColor.blueColor()
				default:
					print("invalid")
				}
			}
		}
	}
	
	func validateWordFound(){
		if self.userEnteredString.characters.count == 4 {
			if isWordFound(){
				print("word found")
				timerDisplay()
			}else{
				timer2Display()
			}
		}

	}
	
	func timer2Display(){
		
		NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "resetWordLabel", userInfo: nil, repeats: false)
	}
	
	func resetWordLabel(){
		self.userEnteredString = ""
		shakeUserEnteredLabel()
		resetLabels()
		resetLetterButtons()
	}
	
	func setButtonColor(button:UIButton, enabled: Bool){
		if !enabled {
			button.backgroundColor = UIColor.lightGrayColor()
		}else{
			button.backgroundColor = UIColor.blueColor()
		}
	}
	
	func timerDisplay(){
		
		self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "resetScreen", userInfo: nil, repeats: false)
		}
	
	func addTimeUpSubview(){
		
		let label = UILabel(frame:CGRect(x: self.view.center.x - ((self.view.bounds.width * 0.75)/2), y: self.view.center.y, width: self.view.bounds.width * 0.75, height: self.view.bounds.height * 0.25))
		label.text = "time's up"
		label.textColor = UIColor.blackColor()
		label.textAlignment = NSTextAlignment.Center
		label.font = UIFont.systemFontOfSize(30.0)
		view.addSubview(label)
	}
	
	func updateProgressBar(){
		
		let moveLeft = CABasicAnimation(keyPath: "position.x")
		moveLeft.toValue = 0
		
		let shrinkView = CABasicAnimation(keyPath: "bounds.size.width")
		shrinkView.toValue = 0
		
		let groupAnimation = CAAnimationGroup()
		groupAnimation.duration = 15.0
		groupAnimation.fillMode = kCAFillModeForwards
		groupAnimation.animations = [moveLeft, shrinkView]
		groupAnimation.delegate = self
		
	

		progressBar.layer.addAnimation(groupAnimation, forKey: "groupAnimation")
	
	}
	
	func shakeUserEnteredLabel(){

	
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = 0.09
		animation.repeatCount = 2
		animation.autoreverses = true
		animation.fromValue = NSValue(CGPoint: CGPointMake(self.firstLetterLabel.center.x - 5, firstLetterLabel.center.y))
		animation.toValue = NSValue(CGPoint: CGPointMake(self.firstLetterLabel.center.x + 5, firstLetterLabel.center.y))
		firstLetterLabel.layer.addAnimation(animation, forKey: "position")
		
		animation.fromValue = NSValue(CGPoint: CGPointMake(self.secondLetterLabel.center.x - 5, secondLetterLabel.center.y))
		animation.toValue = NSValue(CGPoint: CGPointMake(self.secondLetterLabel.center.x + 5, secondLetterLabel.center.y))
		secondLetterLabel.layer.addAnimation(animation, forKey: "position")
		
		animation.fromValue = NSValue(CGPoint: CGPointMake(self.thirdLetterLabel.center.x - 5, thirdLetterLabel.center.y))
		animation.toValue = NSValue(CGPoint: CGPointMake(self.thirdLetterLabel.center.x + 5, thirdLetterLabel.center.y))
		thirdLetterLabel.layer.addAnimation(animation, forKey: "position")
		
		animation.fromValue = NSValue(CGPoint: CGPointMake(self.fourthLetterLabel.center.x - 5, fourthLetterLabel.center.y))
		animation.toValue = NSValue(CGPoint: CGPointMake(self.fourthLetterLabel.center.x + 5, fourthLetterLabel.center.y))
		fourthLetterLabel.layer.addAnimation(animation, forKey: "position")
	}
	
	override func animationDidStop(anim: CAAnimation, finished flag: Bool)
	{
		
		if flag {
				NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "addTimeUpSubview", userInfo: nil, repeats: false)
			resetLabels()
			UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.topStackView.alpha = 0}, completion: nil)
			UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.progressBar.alpha = 0}, completion: nil)
				UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.staticProgressBar.alpha = 0}, completion: nil)
			
			UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.bottomStackView.alpha = 0}, completion: { _ in self.presentGameOverScreen() })
	
		}
	}
	
	func presentGameOverScreen(){
		let vc = self.storyboard?.instantiateViewControllerWithIdentifier("gameover") as! GameOverViewController
		vc.score = self.score
		vc.word = self.wordSet.first!
		self.presentViewController(vc, animated: true, completion: {_ in self.resetTimerAndAnimations()})
	}
	
	func resetScreen(){
		isMenuTapped = false
		resetProgressBar()
		progressBar.backgroundColor = UIColor.blueColor()
		self.userEnteredString = ""
		resetLabels()
		resetLetterButtons()
		self.timer.invalidate()
		updateScore()
		presentNewWord()
		
	}
	
	func resetProgressBar(){
		progressBar.bounds.size.width = self.progressBarWidth
		progressBar.layer.removeAllAnimations()
	}
	
	func resetLabels(){
		firstLetterLabel.text = ""
		firstLetterLabel.backgroundColor = UIColor.lightGrayColor()
		secondLetterLabel.text = ""
		secondLetterLabel.backgroundColor = UIColor.lightGrayColor()
		thirdLetterLabel.text = ""
		thirdLetterLabel.backgroundColor = UIColor.lightGrayColor()
		fourthLetterLabel.text = ""
		fourthLetterLabel.backgroundColor = UIColor.lightGrayColor()
	}
	
	func resetLetterButtons(){
		isFirstButtonEnabled = true
		isSecondButtonEnabled = true
		isThirdButtonEnabled = true
		isFourthButtonEnabled = true
		setButtonColor(firstLetterButton, enabled: isFirstButtonEnabled)
		setButtonColor(secondLetterButton, enabled: isSecondButtonEnabled)
		setButtonColor(thirdLetterButton, enabled: isThirdButtonEnabled)
		setButtonColor(fourthLetterButton, enabled: isFourthButtonEnabled)
	}
	
	func presentNewWord(){
		getWordFromArray()
		if self.charList != "" {
			setLetterTile(self.charList)
		
		}
		updateProgressBar()
	}
	
	func updateScore(){
			++score
			scoreLabel.text = "Score : " + String(score)
	}
	
	func resetTimerAndAnimations(){
				progressBar.layer.removeAllAnimations()
				if self.timer != nil {
					self.timer.invalidate()
				}
		self.view.window?.layer.removeAnimationForKey("FromRight")
		self.view.window?.layer.removeAllAnimations()
	}
	
	func playButtonSound(){
		av.playbuttonBeep()
	}
	
	@IBAction func menuButtonTapped(sender : UIButton!){
		isMenuTapped = !isMenuTapped
		if isMenuTapped {
			sender.setTitle("Tap again to exit", forState:  UIControlState.Normal)
			
		}else{
		self.presentMainMenu()
	}
	}
	
	func presentMainMenu(){
		
		let animation = CATransition()
		animation.duration = 0.5
		animation.type = kCATransitionPush
		animation.subtype = kCATransitionFromLeft
		animation.timingFunction = CAMediaTimingFunction(name: "easeInEaseOut")
		
		let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
		self.view.window?.layer.addAnimation(animation, forKey: "FromLeft")
		
		self.presentViewController(vc, animated: false, completion: {self.resetTimerAndAnimations()})
	}
	
}