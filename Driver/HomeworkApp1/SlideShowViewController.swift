////
////  SlideShowViewController.swift
////  HomeworkApp1
////
////  Created by Hoon H. on 2015/02/26.
////
////
//
//
//
//import Foundation
//import UIKit
//import KenBurns
//
//
//
//let	APPROX_SHOW_DURATION	=	Float(3)
//
//
//
//
//
//
//
/////	First trial.
/////	Tried to use Ken-Burns effect.
/////	It works, but user interaction for backward navigation becomes vague.
/////	Abandons, and changes plan to use plain horizontal sliding using `UIScrollView`.
//final class SlideShowViewController: UIViewController {
//	
//	var	keywordData:String? {
//		didSet {
//			internals.listTransmission?.cancel()
//			if let s = keywordData {
//				internals.listTransmission	=	Client.fetchImageURLs(s, completion: { [unowned self](imageURLs) -> () in
//					//	It's a logic bug if this is called after `self` deallocated.
//					
//					
//				})
//			}
//		}
//	}
//	
//	override func viewWillAppear(animated: Bool) {
//		super.viewWillAppear(animated)
//		
//		self.view.addSubview(display.view)
//		self.addChildViewController(display)
//		
//		display.view.setTranslatesAutoresizingMaskIntoConstraints(false)
//		
//		constraints	=	[
//			NSLayoutConstraint(item: display.view, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0),
//			NSLayoutConstraint(item: display.view, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0),
//			NSLayoutConstraint(item: display.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0),
//			NSLayoutConstraint(item: display.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0),
//		]
//		self.view.addConstraints(constraints)
//	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//		
//	}
//	
//	override func viewWillDisappear(animated: Bool) {
//		super.viewWillDisappear(animated)
//		
//		internals.listTransmission?.cancel()
//	}
//	override func viewDidDisappear(animated: Bool) {
//		super.viewDidDisappear(animated)
//		
//		self.view.removeConstraints(constraints)
//		display.removeFromParentViewController()
//		display.view.removeFromSuperview()
//	}
//	
//	////
//	
//	private let internals		=	InternalController()
//	private let	display			=	SlideShowDisplayViewController()
//	private var	constraints		=	[] as [NSLayoutConstraint]
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
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//private final class InternalController {
//	var	listTransmission	=	nil as Transmission?
//	
//	init() {
//		
//	}
//	deinit {
//		listTransmission?.cancel()
//	}
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
//
//
//
//
//
//
//
//
//
//
//private final class SlideShowDisplayViewController: UIViewController, KenBurnsViewDelegate {
//	
//	var	imagesData:[UIImage]? {
//		didSet {
//			if let _ = imagesData {
//				kenBurnsView.stopAnimation()
//			}
//		}
//	}
//	
//	var kenBurnsView:JBKenBurnsView {
//		get {
//			return	super.view as! JBKenBurnsView
//		}
//	}
//	
//	////
//	
//	override func loadView() {
//		super.view	=	JBKenBurnsView()
//	}
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		
//		view.backgroundColor	=	UIColor.blackColor()
//		kenBurnsView.delegate	=	self
//	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//		
//		let	u	=	NSBundle.mainBundle().pathForResource("sample1", ofType: "jpg")!
//		let	m	=	UIImage(contentsOfFile: u)!
//		self.kenBurnsView.addImage(m)
//		self.kenBurnsView.animateWithImages([m], transitionDuration: APPROX_SHOW_DURATION, initialDelay: 1, loop: true, isLandscape: true)
//	}
//	
//}
//
//
//
//
//
//extension SlideShowDisplayViewController: KenBurnsViewDelegate {
//	
//	@objc
//	func kenBurns(kenBurns: JBKenBurnsView!, didShowImage image: UIImage!, atIndex index: UInt) {
//		println(kenBurns.images())
//	}
//	
//	@objc
//	func kenBurns(kenBurns: JBKenBurnsView!, didFinishAllImages images: [AnyObject]!) {
//		println(kenBurns.images())
//	}
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
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
