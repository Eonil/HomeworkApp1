////
////  SlideViewController2.swift
////  HomeworkApp1
////
////  Created by Hoon H. on 2015/02/26.
////
////
//
//import Foundation
//import UIKit
//
/////	Touch drag gesture based implementation.
//final class SlideViewController2: UIViewController {
//	func queueImageURLs(us:[NSURL]) {
//		
//	}
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//	
//		let	g1	=	UIPanGestureRecognizer(target: reactions, action: "panGestureDidRecognize:")
//		view.addGestureRecognizer(g1)
//		
//		////
//		
//		reactions.owner	=	self
//	}
//	
//	
//	override func viewWillAppear(animated: Bool) {
//		super.viewWillAppear(animated)
//		
//	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//	}
//	
//	////
//	
//	private let	reactions	=	ReactionController()
//}
//
//
//
//@objc
//private final class ReactionController: NSObject {
//	weak var owner: SlideViewController2?
//	
//	let	sample1	=	UIView()
//	
//	override init() {
//		super.init()
//	}
//	@objc
//	func panGestureDidRecognize(sender:UIPanGestureRecognizer) {
//		sample1.backgroundColor	=	UIColor.brownColor()
//		if sample1.superview == nil {
//			sample1.frame			=	CGRect(x: 0, y: 0, width: 100, height: 100)
//			owner!.view.addSubview(sample1)
//		}
//		
//		
//		let	pos	=	sender.locationInView(owner!.view)
//		let	vel	=	sender.velocityInView(owner!.view)
//		
//		switch sender.state {
//		case .Possible:
//			break
//			
//		case .Began:
//			sample1.layer.removeAllAnimations()
//			break
//			
//		case .Changed:
//			sample1.center	=	CGPoint(x: pos.x, y: 0)
//			break
//			
//		case .Ended:
//			let	len	=	sample1.center.x
//			let	rat	=	len / abs(vel.x)
//			let	sv	=	CGFloat(rat)
//			let	dur	=	NSTimeInterval(max(min(rat, CGFloat(1)), 0.2))
//
//			UIView.animateWithDuration(dur, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: sv, options: UIViewAnimationOptions.allZeros, animations: { [unowned self] () -> Void in
//				let	p1			=	CGPoint(x: 0, y: CGFloat(0))
//				self.sample1.center	=	p1
//			}, completion: { (cancel) -> Void in
//			})
////			sample1.removeFromSuperview()
//			break
//			
//		case .Cancelled:
////			sample1.removeFromSuperview()
//			break
//			
//		case .Failed:
////			sample1.removeFromSuperview()
//			break
//		}
//	}
//	
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
