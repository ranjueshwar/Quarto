//
//  IAPurchaseViewController.swift
//  Quarto
//
//  Created by Prathap Murthy on 25/08/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import UIKit
import QFramework

class IAPurchaseViewController: UIViewController {

	
	
    override func viewDidLoad() {
        super.viewDidLoad()
			
			fetchIAPProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func fetchIAPProducts(iapService: FCIAPService = FCIAPService()){
	iapService.validateProductIdentifiers(iapService.getProductIdentifiers())
		iapService.printProductDetails()
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
