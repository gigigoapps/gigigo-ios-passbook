//
//  ViewController.swift
//  GIGLibrary
//
//  Created by Alejandro Jiménez Agudo on 9/3/16.
//  Copyright © 2016 Gigigo SL. All rights reserved.
//

import UIKit
import GIGPassbook
import GIGLibrary


class ViewController: UIViewController {
	
	fileprivate let passbook = Passbook()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		LogManager.shared.appName = "GIGPassbook"
		LogManager.shared.logLevel = .debug
	}
	
	@IBAction func onButtonDownloadTap(_ sender: AnyObject) {
		let url = "https://api-mcd.q.gigigoapps.com/v1/campaign/Lk034vMjO9S8oooVDnPY/coupon/kvweME3RGzsnKKKOVeko/passbook"
		
		self.passbook.addPassbookFromUrl(url) { result in
			switch result {
				
			case .success:
				LogInfo("Passbook: downloaded successfully")
				
			case .unsupportedVersionError(_):
				LogInfo("Passbook: Unsupported version")
				
			case .error(let error):
				LogInfo("Passbook: Error")
				LogError(error)
			}
		}
	}
	
}
