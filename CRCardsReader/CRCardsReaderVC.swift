//
//  CRCardsReaderVC.swift
//  CRCardsReader
//
//  Created by chenglu li on 14/11/2016.
//  Copyright © 2016 Chenglu_Li. All rights reserved.
//

import UIKit
import Caishen
import SnapKit

class CRCardsReaderVC: UIViewController {
	
	// Rect here is random, it is required to init CardTextField
	// properly, CGRect.zero does not work here.
	let cardTextField = CardTextField(frame:CGRect(x: 0, y: 0, width: 20, height: 20 ))
	
	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpCardTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// UI Setting
	func setUpCardTextField() {
		
		cardTextField.cardTextFieldDelegate = self
		
		cardTextField.placeholder = "0000000000000000"
		
		self.view.addSubview(cardTextField)
		cardTextField.snp.makeConstraints { [unowned self] (make) in
			let parentHeight = self.view.frame.height
			make.center.equalTo(self.view)
			make.edges.equalTo(UIEdgeInsetsMake(parentHeight / 2 - 20, 30, parentHeight / 2 - 20, 30))
		}
	}
}

// MARK: - CardTextFieldDelegate
extension CRCardsReaderVC: CardTextFieldDelegate {
	
	func cardTextFieldShouldShowAccessoryImage(_ cardTextField: CardTextField) -> UIImage? {
		let imgName = CRLocalImages.cardReadingIcon.imgName
		return UIImage(named: imgName)
	}
	
	func cardTextFieldShouldProvideAccessoryAction(_ cardTextField: CardTextField) -> (() -> ())? {
		
		let cardTextsHandler = {
			[weak self] in
			guard let cardIOViewController = CardIOPaymentViewController(paymentDelegate: self)
			else
			{
				return
			}
			
			self?.present(cardIOViewController, animated: true, completion: nil)
		}
		
		return cardTextsHandler
	}
	
	func cardTextField(_ cardTextField: CardTextField, didEnterCardInformation information: Card, withValidationResult validationResult: CardValidationResult) {
		if(validationResult == .Valid) {
			let title = "Yay!"
			let message = "You have successfully added your CARD!"
			let actionTitle = "Hooray!!"
			
			CRHelper.showAlterWith(title: title, message: message, actionTitle: actionTitle, vc: self)
		}
	}
}

// MARK: - CardIOPaymentViewControllerDelegate
extension CRCardsReaderVC: CardIOPaymentViewControllerDelegate {
	
	func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
		paymentViewController.dismiss(animated: true, completion: nil)
	}
	
	func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
		
		// Not working properly with prefill
		
		cardTextField.prefill(cardInfo.cardNumber, month: Int(cardInfo.expiryMonth), year: Int(cardInfo.expiryYear), cvc: cardInfo.cvv)
		
		fillInCardTextField(with: cardInfo)

		paymentViewController.dismiss(animated: true, completion: nil)
	}
	
	func fillInCardTextField(with cardInfo: CardIOCreditCardInfo) {
		
		let expiryMonth = String(cardInfo.expiryMonth)
		let expiryYear = String(cardInfo.expiryYear)
		
		cardTextField.monthTextField.text = expiryMonth
		cardTextField.yearTextField.text = expiryYear.substring(from: expiryYear.index(expiryYear.endIndex, offsetBy: -2))
		
		if let cvv = cardInfo.cvv {
			cardTextField.cvcTextField.text = cvv
		}
	}
}

