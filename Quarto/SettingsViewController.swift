//
//  SettingsViewController.swift
//  Quarto
//
//  Created by Prathap Murthy on 22/07/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
	
	@IBOutlet weak var soundEffect: UIButton!
	@IBOutlet weak var music: UIButton!
	@IBOutlet weak var restorePurchases: UIButton!
	@IBOutlet weak var removeAds: UIButton!
	@IBOutlet weak var moreGames: UIButton!
	@IBOutlet weak var contactUs: UIButton!
	@IBOutlet weak var back: UIButton!
	
	@IBOutlet var superView: UIView!
	
	override func viewDidLoad() {
		// Load user preferences
		
	}
	
	override func viewDidDisappear(animated: Bool) {
		// Save user preferences
	}
	
	
	@IBAction func sfxButtonTapped(sender: PushButtonView!){
		
	}
	
	@IBAction func musicButtonTapped(sender: PushButtonView!){
		sender.isButtonPressed = !sender.isButtonPressed
		sender.setNeedsDisplayInRect(sender.bounds)
	}
	
	@IBAction func restorePurchasesButtonTapped(sender: PushButtonView!){
		
	}
	
	@IBAction func removeAdsButtonTapped(sender: PushButtonView!){
		let vc = self.storyboard?.instantiateViewControllerWithIdentifier("IAP") as! IAPurchaseViewController
		self.presentViewController(vc, animated: false, completion: nil)
	}
	
	
	@IBAction func moreGamesButtonTapped(sender: PushButtonView!){
		
	}
	
	@IBAction func contactUsButtonTapped(sender: PushButtonView!){
		
	}
	
	@IBAction func backButtonTapped(sender: UIButton!){
		let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
		
		
		self.presentViewController(vc, animated: false, completion: nil)
	}
	
	
}