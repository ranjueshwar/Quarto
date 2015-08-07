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
	
	@IBOutlet var superView: UIView!
	
	override func viewDidLoad() {
		print("superview.width\(superView.bounds.width)")
		print("superview.height\(superView.bounds.height)")
		print("superview.leadingx\(superView.leadingAnchor)")
		print("superview.leadingy\(superView.trailingAnchor)")
		
		
	}
	
	
	@IBAction func sfxButtonTapped(sender: UIButton!){
		
	}
	
	@IBAction func musicButtonTapped(sender: UIButton!){
		
	}
	
	@IBAction func restorePurchasesButtonTapped(sender: UIButton!){
		
	}
	
	@IBAction func removeAdsButtonTapped(sender: UIButton!){
		
	}
	
	
	@IBAction func moreGamesButtonTapped(sender: UIButton!){
		
	}
	
	@IBAction func contactUsButtonTapped(sender: UIButton!){
		
	}
	
	
}