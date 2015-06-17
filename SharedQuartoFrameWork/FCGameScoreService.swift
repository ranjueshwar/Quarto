//
//  FCGameOverService.swift
//  FourCharacters
//
//  Created by Prathap Murthy on 04/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import Foundation


public class FCGameScoreService {
	
	var userDefaults: NSUserDefaults
	let gameScore = "GAME_SCORE"
	let highestScore = "HIGHEST_SCORE"
	
	public init(){
		userDefaults = NSUserDefaults.standardUserDefaults()
	}
	
	public func getScore() -> Int {
		return userDefaults.integerForKey(gameScore)
	}
	
	public func getHighestScore() -> Int {
		return userDefaults.integerForKey(highestScore)
	}
	
	public func updateGameScoreandHighestScore() {
		let newScore = getScore() + 1
		setGameScore(newScore)
		if newScore > getHighestScore() {
			setHighestScore(newScore)
		}
	}
	
	public func setGameScore(score: Int){
		userDefaults.setInteger(score , forKey: gameScore)
	}
	
	public func setHighestScore(score: Int) {
		userDefaults.setInteger(score , forKey: highestScore)
		
	}
	
	public func resetGameScore() {
		userDefaults.setInteger(0 , forKey: gameScore)
		
	}
	
	public func updateHighestScore(){
		getScore()
	}
	
	
}