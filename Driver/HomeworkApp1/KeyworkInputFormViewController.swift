//
//  KeyworkInputFormViewController.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit




///	Takes keyword user input.
final class KeyworkdInputFormViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor		=	UIColor.whiteColor()
		
		userInputTextField.borderStyle	=	UITextBorderStyle.RoundedRect
		userInputTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		if userInputTextField.superview == nil {
			self.view.addSubview(userInputTextField)
			self.view.addConstraints([
				NSLayoutConstraint(item: userInputTextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0),
				NSLayoutConstraint(item: userInputTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -100),
				NSLayoutConstraint(item: userInputTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: -20),
				NSLayoutConstraint(item: userInputTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 44),
				])
		}
		
		////
		
		reactions.owner					=	self
		userInputTextField.delegate		=	reactions
	}
	override func viewWillAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
	}
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	////
	
	private let	userInputTextField		=	UITextField()
	private let	reactions				=	ReactionController()
}







@objc
private class ReactionController: NSObject, UITextFieldDelegate {
	weak var owner: KeyworkdInputFormViewController?
	
	@objc
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return	true
	}
	
	@objc
	func textFieldShouldEndEditing(textField: UITextField) -> Bool {
		return	true
	}
	
	@objc
	func textFieldDidEndEditing(textField: UITextField) {
		let	nc								=	UINavigationController()
		let	vc								=	KeywordSlideViewController()
		vc.navigationItem.leftBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "userDidTapDoneButton:")
		vc.keywordString					=	textField.text
		nc.pushViewController(vc, animated: false)
		owner!.navigationController!.presentViewController(nc, animated: true) { () -> Void in
		}
	}
	
	@objc
	func userDidTapDoneButton(AnyObject?) {
		owner!.navigationController!.dismissViewControllerAnimated(true, completion: { () -> Void in
		})
	}
}








