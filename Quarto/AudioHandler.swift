//
//  AudioHandler.swift
//  Quarto
//
//  Created by Prathap Murthy on 20/07/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import AVFoundation

class AudioHelper {
	var buttonBeep: AVAudioPlayer!
	
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
	
	
	func setbuttonBeep(vol: Float = 1.0) {
		
		 self.buttonBeep = self.setupAudioPlayerWithFile("snd_deal", type:"caf")
		self.buttonBeep.enableRate = true
		self.buttonBeep.rate = 2.0
		self.buttonBeep.volume = vol
		
	}
	
	func playbuttonBeep(){
		self.buttonBeep.play()
	}
	
}