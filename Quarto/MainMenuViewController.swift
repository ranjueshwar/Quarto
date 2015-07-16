//
//  ViewController.swift
//  Quarto
//
//  Created by Prathap Murthy on 16/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import UIKit
import QFramework

class MainMenuViewController: UIViewController {

	@IBOutlet weak var mainStackView: UIStackView!
	@IBOutlet weak var titleStackView: UIStackView!
	@IBOutlet weak var scoreStackView: UIStackView!
	@IBOutlet weak var buttonsStackView: UIStackView!
	@IBOutlet weak var menuColStackView: UIStackView!
	@IBOutlet weak var menuExpStackView: UIStackView!
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var menuButton: UIButton!
	@IBOutlet weak var settingsButton: UIButton!
	@IBOutlet weak var achivementsButton: UIView!
	@IBOutlet weak var statisticsButton: UIButton!
	@IBOutlet weak var dictionaryButton: UIButton!
	@IBOutlet weak var loginWithFBButton: UIButton!
	@IBOutlet weak var bestScoreLabel: UILabel!
	@IBOutlet weak var menuExpView: UIView!
	@IBOutlet weak var qLabel: UILabel!
	@IBOutlet weak var uLabel: UILabel!
	@IBOutlet weak var aLabel: UILabel!
	@IBOutlet weak var rLabel: UILabel!
	@IBOutlet weak var tLabel: UILabel!
	@IBOutlet weak var oLabel: UILabel!
	
	var circleView: CircleView!
	var secondCircleView: CircleView!
	var menuView: UIView!
	
	var menuButtonPressed: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
	}
	
	override func viewWillAppear(animated: Bool) {
		 circleView = CircleView(frame: view.frame)
		secondCircleView = CircleView(frame: view.frame)
		view.addSubview(circleView)
		view.addSubview(secondCircleView)
		view.sendSubviewToBack(circleView)
		view.sendSubviewToBack(secondCircleView)
	}
	
	override func viewDidAppear(animated: Bool) {
		animations()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("resumeAnimations"), name: UIApplicationDidBecomeActiveNotification, object: nil)
		
		
	}
	
	override func viewWillDisappear(animated: Bool) {
		print("pause animations")
		
	}
	
	override func viewDidDisappear(animated: Bool) {
		print("view did gisappear")
		
	
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func playButtonTapped(sender: UIButton!){
		
		UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2,
			initialSpringVelocity: 0.0, options:[ UIViewAnimationOptions.Autoreverse ,UIViewAnimationOptions.Repeat ] , animations: {
				self.playButton.bounds.size.width += 80.0
			}, completion: {_ in self.setWordsArr()})
		
	}
	
	@IBAction func menuButtonTapped(sender: UIButton!){
		menuButtonPressed = !menuButtonPressed
		if menuButtonPressed {
			menuExpStackView.hidden = false
			//addMenuView()
		} else {
			menuExpStackView.hidden = true
			//removeMenuView()
		}
	}
	
	func setWordsArr(){
		if let wordsArr = getWords() {
			performSegueWithIdentifier("MainGame", sender: wordsArr)
		} else {
			print("no data")
			abort()
		}
	}
	
	func getWords() -> [QWord]!{
		 return FCCoreDataService().getWordsData()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "MainGame" {
			let controller = segue.destinationViewController
			as! MainGameViewController
			controller.wordsArray = getWords()
		}
	}
	
	func resumeAnimations(){
			animations()
	}
	
	func animations(){
		var fromValue = self.playButton.center.y
		
		let ypos = CABasicAnimation(keyPath: "position.y")
		ypos.toValue = fromValue - 10.0
		ypos.autoreverses = true
		ypos.repeatCount = Float.infinity
		ypos.duration = 1.5
		
		ypos.timingFunction = CAMediaTimingFunction(name: "easeInEaseOut")
		playButton.layer.addAnimation(ypos, forKey: "playButton")
		
		
		ypos.beginTime = CACurrentMediaTime() + 0.0
		fromValue = self.qLabel.center.y
		ypos.toValue = fromValue - 10.0
		qLabel.layer.addAnimation(ypos, forKey: "t1")
		
		fromValue = self.uLabel.center.y
		ypos.toValue = fromValue - 10.0
		ypos.beginTime = CACurrentMediaTime() + 0.7
		uLabel.layer.addAnimation(ypos, forKey: "t2")
		
		fromValue = self.aLabel.center.y
		ypos.toValue = fromValue - 10.0
		ypos.beginTime = CACurrentMediaTime() + 1.4
		aLabel.layer.addAnimation(ypos, forKey: "t3")
		
		fromValue = self.rLabel.center.y
		ypos.toValue = fromValue - 10.0
		ypos.beginTime = CACurrentMediaTime() + 2.1
		rLabel.layer.addAnimation(ypos, forKey: "t4")
		
		fromValue = self.tLabel.center.y
		ypos.toValue = fromValue - 10.0
		ypos.beginTime = CACurrentMediaTime() + 2.8
		tLabel.layer.addAnimation(ypos, forKey: "t5")
		
		fromValue = self.oLabel.center.y
		ypos.beginTime = CACurrentMediaTime() + 3.5
		oLabel.layer.addAnimation(ypos, forKey: "t6")
		
		
		circleView.animateCircleRadius(4.0, delay: 0.0)
		secondCircleView.animateCircleRadius(4.0, delay: 2.0)
		circleView.animateCircleAlpha(4.0, delay: 0.0)
		secondCircleView.animateCircleAlpha(4.0, delay: 2.0)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("removeAllAnimations"), name: UIApplicationWillResignActiveNotification, object: nil)
	}
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	func addMenuView(){
		print("add menu view")
		 menuView = UIView()
		menuView.frame = CGRect(x: self.buttonsStackView.frame.origin.x, y: self.buttonsStackView.center.y, width: view.frame.width, height: self.buttonsStackView.frame.height/2)
		
		menuView.center.x = mainStackView.center.x
		
		menuView.backgroundColor = UIColor.lightGrayColor()
		view.addSubview(menuView)
		self.buttonsStackView.frame = CGRect(x: self.buttonsStackView.frame.origin.x, y: self.buttonsStackView.frame.origin.y, width: self.buttonsStackView.frame.width, height: self.buttonsStackView.frame.height/2)
		
		UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 1.0,
			initialSpringVelocity: 1.0, options:[ UIViewAnimationOptions.CurveEaseInOut ] , animations: {
				self.buttonsStackView.alignment = UIStackViewAlignment.Top
			}, completion: nil)
		
		}
	
	func removeMenuView(){
		menuView.removeFromSuperview()
		self.buttonsStackView.frame = CGRect(x: self.buttonsStackView.frame.origin.x, y: self.buttonsStackView.frame.origin.y, width: self.buttonsStackView.frame.width, height: self.buttonsStackView.frame.height*2)
		self.buttonsStackView.alignment = UIStackViewAlignment.Center
	}
	
	func removeAllAnimations(){
		print("removealn")
		playButton.layer.removeAnimationForKey("ypos")
		qLabel.layer.removeAllAnimations()
		uLabel.layer.removeAllAnimations()
		aLabel.layer.removeAllAnimations()
		rLabel.layer.removeAllAnimations()
		tLabel.layer.removeAllAnimations()
		oLabel.layer.removeAllAnimations()
	}
	
	@IBAction func achievementsButtonTapped( sender: AnyObject!){
		print(" ach tap")
	}
}

