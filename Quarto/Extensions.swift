////
////  Extensions.swift
////  Quarto
////
////  Created by Prathap Murthy on 20/07/15.
////  Copyright © 2015 Prathap Murthy. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class Extensions: NSObject, UIViewControllerAnimatedTransitioning{
//	weak var transitionContext: UIViewControllerContextTransitioning?
//
//	
//	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
//		return 0.5
//	}
//	
//	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//		//1
//  self.transitionContext = transitionContext
//		
//  //2
//  let containerView = transitionContext.containerView()
//		var fromViewController: UIViewController
//		if var vc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey){
//			 fromViewController = vc as UIViewController
//		}
//		var toViewController: UIViewController
//		if var vc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey){
//			 toViewController = vc as UIViewController
//		}
//  var button = fromViewController.button
//		
//  //3
//  containerView.addSubview(toViewController.view)
//	}
//}
//
//extension UIModalTransitionStyle {
//	
//}