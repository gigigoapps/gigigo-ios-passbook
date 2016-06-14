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
	
	private let passbook = Passbook()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		LogManager.shared.appName = "GIGPassbook"
		LogManager.shared.logLevel = .Debug
	}
	
	@IBAction func onButtonDownloadTap(sender: AnyObject) {
		let url = "https://api-mcd.q.gigigoapps.com/v1/campaign/Lk034vMjO9S8oooVDnPY/coupon/kvweME3RGzsnKKKOVeko/passbook"
		
		self.passbook.addPassbookFromUrl(url) { result in
			switch result {
				
			case .Success:
				LogInfo("Passbook: downloaded successfully")
				
			case .UnsupportedVersionError(_):
				LogInfo("Passbook: Unsupported version")
				
			case .Error(let error):
				LogInfo("Passbook: Error")
				LogError(error)
			}
		}
	}
	
}
