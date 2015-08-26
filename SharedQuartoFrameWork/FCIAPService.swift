//
//  FCInAppPurchaseService.swift
//  Quarto
//
//  Created by Prathap Murthy on 24/08/15.
//  Copyright © 2015 Prathap Murthy. All rights reserved.
//

import Foundation
import StoreKit


class FCIAPService :NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver{
	
	let defaults = NSUserDefaults.standardUserDefaults()
	var validProducts: [SKProduct] = []
	var productIdentifiers:Set<String> = []
	//var productsRequest:SKProductsRequest?
	
	func getProductIdentifiers() -> Set<String> {
		var productIdentifiers:Set<String> = []
		productIdentifiers.insert(FCConstants.IAP_PID)
		return productIdentifiers
	}
	
	func validateProductIdentifiers(productIds: Set<String>){
		if (SKPaymentQueue.canMakePayments())
		{
			
			let productsRequest = SKProductsRequest(productIdentifiers: productIds);
			productsRequest.delegate = self;
			productsRequest.start();
			print("Fetching Products");
		}else{
			print("Cannot perform In App Purchases");
		}
		
	}
	
	func getValidProducts() -> [SKProduct] {
		return self.validProducts
	}
	
	
	func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse){
		print("Request the IAPS Products")
		let count : Int = response.products.count
		if (count > 0) {
			self.validProducts = response.products
		} else {
			print("nothing")
		}
		
		if response.invalidProductIdentifiers.count != 0 {
			print(response.invalidProductIdentifiers.description)
		}

	}
	

	
	func printProductDetails(){
		for validProduct in self.validProducts {
		  print(validProduct.productIdentifier)
			print(validProduct.priceLocale)
			print(validProduct.localizedTitle)
			print(validProduct.localizedDescription)
      print(validProduct.price)
		}

	}
	
	func request(request: SKRequest, didFailWithError error: NSError) {
		print("Error Fetching product information");
	}
	
	func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		//a
	}
}

