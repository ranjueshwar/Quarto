//
//  CircleAnimation.swift
//  Quarto
//
//  Created by Prathap Murthy on 30/06/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import UIKit

class CircleView : UIView {
	
	var circleLayer: CAShapeLayer!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
		
		// Use UIBezierPath as an easy way to create the CGPath for the layer.
		// The path should be the entire circle.
		let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10) * 0.001, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
		
		// Setup the CAShapeLayer with the path, colors, and line width
		circleLayer = CAShapeLayer()
		circleLayer.path = circlePath.CGPath
		circleLayer.fillColor = UIColor.clearColor().CGColor
		circleLayer.strokeColor = UIColor(red: 0.74, green: 0.28, blue: 0.19, alpha: 1.0).CGColor
		circleLayer.lineWidth = 1.0;
		
		// Don't draw the circle initially
		circleLayer.strokeEnd = 1.0
		
		// Add the circleLayer to the view's layer's sublayers
		layer.addSublayer(circleLayer)
	}

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func animateCircle(duration: NSTimeInterval) {
		// We want to animate the strokeEnd property of the circleLayer
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		
		// Set the animation duration appropriately
		animation.duration = duration
		
		// Animate from 0 (no circle) to 1 (full circle)
		animation.fromValue = 0
		animation.toValue = 1
		
		// Do a linear animation (i.e. the speed of the animation stays the same)
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		
		// Set the circleLayer's strokeEnd property to 1.0 now so that it's the
		// right value when the animation ends.
		circleLayer.strokeEnd = 1.0
		
		// Do the actual animation
		circleLayer.addAnimation(animation, forKey: "animateCircle")
	}
	
	func animateCircleRadius(duration: NSTimeInterval, delay: NSTimeInterval) {
		let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10) * 0.65, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
		// We want to animate the strokeEnd property of the circleLayer
		let animation = CABasicAnimation(keyPath: "path")
		
		// Set the animation duration appropriately
		animation.duration = duration
		
		// Animate from 0 (no circle) to 1 (full circle)
	
		animation.toValue = circlePath.CGPath
		//animation.autoreverses = true
		animation.repeatCount = Float.infinity
		// Do a linear animation (i.e. the speed of the animation stays the same)
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		animation.beginTime = CACurrentMediaTime() + delay
		// Set the circleLayer's strokeEnd property to 1.0 now so that it's the
		// right value when the animation ends.
		circleLayer.strokeEnd = 1.0
		
		// Do the actual animation
		circleLayer.addAnimation(animation, forKey: "animateCircleRadius")
	}
	
	func animateCircleAlpha(duration: NSTimeInterval, delay: NSTimeInterval){
		
		let animation = CABasicAnimation(keyPath: "strokeColor")
	
		// Set the animation duration appropriately
		animation.duration = duration
		animation.toValue = UIColor(red: 0.74, green: 0.28, blue: 0.19, alpha: 0.0).CGColor
		//animation.autoreverses = true
		animation.repeatCount = Float.infinity
		// Do a linear animation (i.e. the speed of the animation stays the same)
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		animation.beginTime = CACurrentMediaTime() + delay
		
		
		// Do the actual animation
		circleLayer.addAnimation(animation, forKey: "animateCircleAlpha")

	}

	
	// ADD in view controller
	
	/*func addCircleView() {
		let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
		let circleWidth = CGFloat(200)
		let circleHeight = circleWidth
		
		// Create a new CircleView
		let circleView = CircleView(frame: CGRectMake(diceRoll, 0, circleWidth, circleHeight))
		view.addSubview(circleView)
		
		// Animate the drawing of the circle over the course of 1 second
		circleView.animateCircle(1.0)
	}*/


}