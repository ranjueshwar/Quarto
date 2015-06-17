//
//  FCUserPreferenceService.swift
//  FourCharacters
//
//  Created by Prathap Murthy on 04/06/15.
//  Copyright (c) 2015 Prathap Murthy. All rights reserved.
//

import Foundation

public class FCUserPreferenceService {
	
	var userDefaults: NSUserDefaults
	
	public init() {
		userDefaults = NSUserDefaults.standardUserDefaults()
	}
	
	public func setUserPreference(key: String,value: AnyObject) {
			userDefaults.setValue(value, forKey: key)
	}
	
	public func getUserPreference(key:String) -> AnyObject! {
		if let value: AnyObject = userDefaults.valueForKey(key) {
			return value
		}else {
			return nil
		}
	}
}