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
	var userEnteredString = ""
	var timer: NSTimer!
	var progressBarWidth: CGFloat = 0.0
	var score: Int = 0
	var buttonBeep = AVAudioPlayer()
	
	func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
 
		let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
		let url = NSURL.fileURLWithPath(path!)
		var audioPlayer:AVAudioPlayer?
			do{
				audioPlayer = try AVAudioPlayer(contentsOfURL: url)
			}catch{
				print("Error while setting up AudioPlayer for : \(file)")
			}
		
		return audioPlayer!
	}
	
	override func viewDidLoad() {
	
		buttonBeep = self.setupAudioPlayerWithFile("snd_deal", type:"caf")
		buttonBeep.enableRate = true
		buttonBeep.rate = 2.0
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(false)
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
		print("vdis")
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
		
	}
	
	@IBAction func secondLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[advance(self.charList.startIndex, 1)]
		self.setTappedLabel(text, enabled: isSecondButtonEnabled)
		isSecondButtonEnabled = !isSecondButtonEnabled
		self.setButtonColor(secondLetterButton, enabled: isSecondButtonEnabled)
	}
	
	
	@IBAction func thirdLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[advance(self.charList.startIndex, 2)]
		self.setTappedLabel(text, enabled: isThirdButtonEnabled)
		isThirdButtonEnabled = !isThirdButtonEnabled
		self.setButtonColor(thirdLetterButton, enabled: isThirdButtonEnabled)
	}
	
	
	@IBAction func fourthLetterTapped(sender: UIButton){
		playButtonSound()
		let text = self.charList[advance(self.charList.startIndex, 3)]
		self.setTappedLabel(text, enabled: isFourthButtonEnabled)
		isFourthButtonEnabled = !isFourthButtonEnabled
		self.setButtonColor(fourthLetterButton, enabled: isFourthButtonEnabled)
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
			if self.userEnteredString.characters.count == 4 && isWordFound() {
				print("word found")
				timerDisplay()
			}
		}
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
	
	override func animationDidStop(anim: CAAnimation, finished flag: Bool)
	{
		
		if flag {
			let vc = self.storyboard?.instantiateViewControllerWithIdentifier("gameover") as! GameOverViewController
			vc.score = self.score
			vc.word = self.wordSet.first!
			self.presentViewController(vc, animated: true, completion: {_ in self.resetTimerAndAnimations()})
		}
	}
	
	func resetScreen(){
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
			scoreLabel.text = String(score)
	}
	
	func resetTimerAndAnimations(){
				progressBar.layer.removeAllAnimations()
				if self.timer != nil {
					self.timer.invalidate()
				}
	}
	func playButtonSound(){
		if buttonBeep.playing{
			buttonBeep.stop()
		}
		buttonBeep.play()
	}
	
}