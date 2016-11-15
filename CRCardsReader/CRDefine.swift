//
//  CRDefine.swift
//  CRCardsReader
//
//  Created by chenglu li on 14/11/2016.
//  Copyright © 2016 Chenglu_Li. All rights reserved.
//

import Foundation

enum CRLocalImages {
	case cardReadingIcon
	
	var imgName: String {
		switch self {
		case .cardReadingIcon:
			return "Card_io"
		default:
			return "Yo"
		}
	}
}
