//
//  PassbookService.swift
//  GIGLibrary
//
//  Created by Alejandro Jiménez on 8/3/16.
//  Copyright © 2016 Gigigo SL. All rights reserved.
//

import Foundation
import GIGLibrary
import PassKit


enum PassbookServiceResult {
	case success(PKPass)
	case error(NSError)
	case unsupportedVersionError(NSError)
}


class PassbookService {

	func fetchPassFromURL(_ url: URL, completionHandler: @escaping (PassbookServiceResult) -> Void) {
		let request = Request(
			method: "GET",
			baseUrl: url.absoluteString,
			endpoint: ""
		)
		
		request.fetch { response in
			switch response.status {
				
			case .success:
				self.onSuccess(response, completionHandler: completionHandler)
				
			default:
				self.onFail(response, completionHandler: completionHandler)
			}
		}
	}
	
	
	// MARK: - Private Helpers
	
	fileprivate func onSuccess(_ response: Response, completionHandler: (PassbookServiceResult) -> Void) {
		guard let data = response.body else {
			let error = self.errorUnknown()
			
			completionHandler(.error(error))
			return
		}
		
		var error: NSError?
		let pass = PKPass(data: data, error: &error)
		
		if let errorUnwrap = error {
			switch errorUnwrap.code {
				
			case PKPassKitError.unsupportedVersionError.rawValue:
				completionHandler(.unsupportedVersionError(errorUnwrap))
				
			default:
				completionHandler(.error(errorUnwrap))
			}
		}
		else {
			completionHandler(.success(pass))
		}
		
	}
	
	fileprivate func onFail(_ response: Response, completionHandler: (PassbookServiceResult) -> Void) {
		guard let error = response.error else {
			let error = self.errorUnknown()
			
			completionHandler(.error(error))
			return
		}
		
		completionHandler(.error(error))
	}
	
	fileprivate func errorUnknown() -> NSError {
		let error = NSError(
			domain: kGIGPassbookErrorDomain,
			code: -1,
			userInfo: [kGIGPassbookErrorMessage: "Unknown error"]
		)
		
		return error
	}
	
}
