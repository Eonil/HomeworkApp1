////
////  SlideShowNavigationController.swift
////  HomeworkApp1
////
////  Created by Hoon H. on 2015/02/26.
////
////
//
//import Foundation
//import UIKit
//
//final class SlideShowNavigationController: UINavigationController {
//	
//	var keywordData:String? {
//		get {
//			return	display.keywordData
//		}
//		set(v) {
//			display.keywordData	=	v
//		}
//	}
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		self.view.backgroundColor		=	UIColor.blackColor()
//		self.navigationBar.barStyle		=	UIBarStyle.BlackTranslucent
//		
//		self.pushViewController(display, animated: false)
//		display.navigationItem.leftBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: reaction, action: "userDidTapDoneButton:")
//		display.navigationItem.rightBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: reaction, action: "userDidTapSaveButton:")
//		
//		reaction.owner	=	self
//	}
//	override func viewWillAppear(animated: Bool) {
//		super.viewWillAppear(animated)
//	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//	}
//	override func viewWillDisappear(animated: Bool) {
//		super.viewWillDisappear(animated)
//	}
//	override func viewDidDisappear(animated: Bool) {
//		super.viewDidDisappear(animated)
//	}
//	
//	////
//	
//	private let	reaction	=	EventReactionController()
//	private let	display		=	OnlineKeywordPhotoSlideViewController()
//}
//
//
//
//
//
//
//
//
//
//@objc
//private final class EventReactionController {
//	weak var owner:SlideShowNavigationController?
//	@objc
//	func userDidTapDoneButton(AnyObject?) {
//		owner!.presentingViewController!.dismissViewControllerAnimated(true, completion: { () -> Void in
//		})
//	}
//	@objc
//	func userDidTapSaveButton(AnyObject?) {
//		
//	}
//}
//
//
//
//
//
//
//
