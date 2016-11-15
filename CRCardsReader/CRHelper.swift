//
//  CRHelper.swift
//  CRCardsReader
//
//  Created by chenglu li on 14/11/2016.
//  Copyright © 2016 Chenglu_Li. All rights reserved.
//

import Foundation

struct CRHelper {
	static func showAlterWith(title: String, message: String, actionTitle: String?, vc: UIViewController){
		
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
		let confirmAction = UIAlertAction(title: actionTitle ?? "OK", style: .default){ action in
			alert.dismiss(animated: true, completion: nil)
		}
		
		alert.addAction(confirmAction)
		vc.present(alert, animated: true, completion: nil)
	}
}
