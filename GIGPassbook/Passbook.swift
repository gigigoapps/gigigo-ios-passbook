//
//  Passbook.swift
//  GIGLibrary
//
//  Created by Alejandro Jiménez on 8/3/16.
//  Copyright © 2016 Gigigo SL. All rights reserved.
//

import Foundation


public let kGIGPassbookErrorDomain = "com.giglibrary.passbook"
public let kGIGPassbookErrorMessage = "GIGPASSBOOK_ERROR_MESSAGE"

public enum PassbookResult {
	case success
	case error(NSError)
	case unsupportedVersionError(NSError)
}

open class Passbook {
	
	fileprivate var service = PassbookService()
	fileprivate var passbookManager = PassbookManager()
	
	
	public init() {}
	
	open func addPassbookFromUrl(_ urlString: String, completionHandler: @escaping (PassbookResult) -> Void) {
		guard let url = URL(string: urlString) else {
			completionHandler(.error(self.errorURLNotValid()))
			return
		}
		
		self.service.fetchPassFromURL(url) { result in
			switch result {
				
			case .success(let pass):
				self.passbookManager.addPass(pass)
				completionHandler(.success)
				
			case .unsupportedVersionError(let error):
				completionHandler(.unsupportedVersionError(error))
				
			case .error(let error):
				completionHandler(.error(error))
			}
		}
		
	}
	
	
	fileprivate func errorURLNotValid() -> NSError {
		let error = NSError(
			domain: kGIGPassbookErrorDomain,
			code: 10000,
			userInfo: [kGIGPassbookErrorMessage: "The url is not valid"]
		)
		
		return error
	}
}
