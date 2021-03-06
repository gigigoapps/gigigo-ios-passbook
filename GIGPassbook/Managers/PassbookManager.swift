//
//  PassbookManager.swift
//  GIGLibrary
//
//  Created by Alejandro Jiménez on 8/3/16.
//  Copyright © 2016 Gigigo SL. All rights reserved.
//

import Foundation
import PassKit
import GIGLibrary


class PassbookManager {
	
	fileprivate var app = Application()
	
	func addPass(_ pass: PKPass) {
		let addVC = PKAddPassesViewController(pass: pass)
        _ = addVC.map({ self.app.presentModal($0) })
	}
	
}
