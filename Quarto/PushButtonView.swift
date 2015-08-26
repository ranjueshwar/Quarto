

import UIKit
@IBDesignable
class PushButtonView: UIButton {

	@IBInspectable var fillColor: UIColor = UIColor.greenColor()
	@IBInspectable var isButtonPressed: Bool = false
	
	let π:CGFloat = CGFloat(M_PI)
	
 override func drawRect(rect: CGRect) {
	
	let path = UIBezierPath(ovalInRect: rect)
	fillColor.setFill()
	path.fill()
	//set up the width and height variables
	//for the horizontal stroke
	let plusHeight: CGFloat = 3.0
	let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
 
	//create the path
	let plusPath = UIBezierPath()
 
	//set the path's line width to the height of the stroke
	plusPath.lineWidth = plusHeight
 
	//move the initial point of the path
	//to the start of the horizontal stroke
	plusPath.moveToPoint(CGPoint(
  x:bounds.width/2 - plusWidth/2 + 0.5,
  y:bounds.height/2 + 0.5))
 
	//add a point to the path at the end of the stroke
	plusPath.addLineToPoint(CGPoint(
  x:bounds.width/2 + plusWidth/2 + 0.5,
  y:bounds.height/2 + 0.5))
 
	//set the stroke color
	UIColor.whiteColor().setStroke()
 
	//draw the stroke
	plusPath.stroke()
	

	//set the path's line width to the height of the stroke
	plusPath.lineWidth = plusHeight
 
	//move the initial point of the path
	//to the start of the horizontal stroke
	plusPath.moveToPoint(CGPoint(
  x:bounds.width/2 + 0.5,
  y:bounds.height/2 - plusWidth/2 + 0.5 ))
 
	//add a point to the path at the end of the stroke
	plusPath.addLineToPoint(CGPoint(
  x:bounds.width/2  + 0.5,
  y:bounds.height/2 + plusWidth/2 + 0.5))
 
	//set the stroke color
	if isButtonPressed {
		UIColor.lightGrayColor().setStroke()
	}else{
		UIColor.whiteColor().setStroke()
	}
 

	//draw the stroke
	plusPath.stroke()
	
	// 1
	let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
 
	// 2
	let radius: CGFloat = max(bounds.width, bounds.height)
 
	// 4
	let startAngle: CGFloat = 0
	let endAngle: CGFloat = 2*π
 
	// 5

	let strokerPath = UIBezierPath(arcCenter: center,
  radius: radius/2 - 2.0,
  startAngle: startAngle,
  endAngle: endAngle,
  clockwise: true)
	
	
	strokerPath.lineWidth = 2.0
	strokerPath.stroke()

}

}
