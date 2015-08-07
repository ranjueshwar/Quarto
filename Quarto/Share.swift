//
//  Share.swift
//  Quarto
//
//  Created by Prathap Murthy on 20/07/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import UIKit

class Share {
	
	func shareTextImageAndURL(viewController: UIViewController,sharingText: String?, sharingImage: UIImage?,sharingURL: NSURL?) {
		var sharingItems = [AnyObject]()
		
		if let text = sharingText {
			sharingItems.append(text)
		}
		if let image = sharingImage {
			sharingItems.append(image)
		}
		//	if let url = sharingURL {
		//		sharingItems.append(url)
		//	}
		//
		let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
		activityViewController.setValue("Quarto subject", forKey: "subject")
		UIActivityTypeMail
		viewController.presentViewController(activityViewController, animated: true, completion: nil)
	}
	

	
	func screenGrab(view: UIView )-> UIImage{
		UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
		view.layer.renderInContext(UIGraphicsGetCurrentContext())
		let	image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	
	
	
}
