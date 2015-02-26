//
//  SlideViewController3.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit







protocol SlideViewController3Delegate: class {
	func slideViewController3DidChangeTitle(s:String)
}

///	`queueImageURLs` to add image URL list.
///	This object will take care of everything else.
///
///	Set a close button at `navigationItem.leftBarButton`.
///	This view controller will not set anything at left bar button slot.
///
///	**Note**
///	`UIPageViewController` internalised to hide details.
final class SlideViewController3: UIViewController {
	weak var delegate: SlideViewController3Delegate?
	
	func queueImageItems(imageItems:[Client.ImageItem]) {
		Debug.assertMainThread()
		
		pushImageItems(imageItems)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.edgesForExtendedLayout					=	UIRectEdge.All
		self.extendedLayoutIncludesOpaqueBars		=	true
		self.automaticallyAdjustsScrollViewInsets	=	false
		self.view.backgroundColor					=	UIColor.blackColor()

		let	g	=	UITapGestureRecognizer(target: reactions, action: "userDidTapOnSlideDisplayView:")
		self.view.addGestureRecognizer(g)
		self.view.addSubview(pageVC.view)
		self.addChildViewController(pageVC)
		self.view.addConstraints([
			NSLayoutConstraint(item: pageVC.view, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: pageVC.view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: pageVC.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: pageVC.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0),
			])
//		for g in pageVC.gestureRecognizers {
//			self.view.addGestureRecognizer(g as! UIGestureRecognizer)
//		}
		pushImageItems([])
		
		navigationItem.rightBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: reactions, action: "userDidTapSaveButton:")
		
		////
		
		reactions.owner		=	self
		pageVC.dataSource	=	reactions
		pageVC.delegate		=	reactions
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navbarOriginHidden	=	self.navigationController!.navigationBarHidden
		self.navigationController!.navigationBarHidden	=	true
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		startSteppingTimer()
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController!.navigationBarHidden	=	self.navbarOriginHidden
		stopSteppingTimer()
	}
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	////
	
	private var	stepper				=	nil as SteppingTimerController?
	private var	navbarOriginHidden	=	false
//	private var	imageURLShuffler	=	ValueShuffler<NSURL>()
	private var futureImageItems	=	[] as [Client.ImageItem]
	private let pageVC				=	UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
	private let reactions			=	ReactionController()
	
	private func pushImageItems(ms:[Client.ImageItem]) {
//		imageURLShuffler.pushSourcePoolValues(us)
		let	us1	=	sortRandomly(ms)
		self.futureImageItems.extend(us1)
		if pageVC.viewControllers.count == 0 {
			if let f = futureImageItems.first {
				let	vc	=	SlidePageViewController()
				vc.imageItem	=	f
				pageVC.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
			}
		}
	}
}



private extension SlideViewController3 {
	func startSteppingTimer() {
		assert(stepper == nil)
		
		stepper	=	SteppingTimerController()
		stepper!.delegate	=	reactions
	}
	func stopSteppingTimer() {
		assert(stepper != nil)
		
		stepper	=	nil
	}
}

private extension SlideViewController3 {
	func findIndexOfImageItemForURL(u:NSURL) -> Int? {
		for i in 0..<futureImageItems.count {
			if futureImageItems[i].URL == u {
				return	i
			}
		}
		return	nil
	}
}

































///	MARK:
///	MARK:	ReactionController

private final class ReactionController: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate, SteppingTimerControllerDelegate {
	weak var owner: SlideViewController3?
	
	@objc
	func userDidTapOnSlideDisplayView(AnyObject?) {
		owner!.navigationController!.setNavigationBarHidden(owner!.navigationController!.navigationBarHidden == false, animated: true)
	}
	
	@objc
	func userDidTapSaveButton(AnyObject?) {
		let vc	=	owner!.pageVC.viewControllers[0] as! SlidePageViewController

		dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
			let	m	=	UIImage(data: NSData(contentsOfURL: vc.imageItem!.URL)!)!
			UIImageWriteToSavedPhotosAlbum(m, nil, nil, nil)
		}
	}
	
	@objc
	func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
		
	}
	@objc
	func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
		owner!.stopSteppingTimer()
		owner!.startSteppingTimer()
		owner!.delegate?.slideViewController3DidChangeTitle(pageViewController.viewControllers[0].navigationItem.title!)
	}
	
	@objc
	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		let	vc	=	viewController as! SlidePageViewController
		if let u = vc.imageItem {
			let	u	=	vc.imageItem!
			let	idx	=	owner!.findIndexOfImageItemForURL(u.URL)!
			if idx > 0 {
				let	u1	=	owner!.futureImageItems[idx-1]
				let	vc1	=	SlidePageViewController()
				vc1.imageItem	=	u1
				return	vc1
			}
		}
		return	nil
	}
	
	@objc
	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
		let	vc	=	viewController as! SlidePageViewController
		if let u = vc.imageItem {
			let	u	=	vc.imageItem!
			let	idx	=	owner!.findIndexOfImageItemForURL(u.URL)!
			if idx < (owner!.futureImageItems.count-1) {
				let	u1	=	owner!.futureImageItems[idx+1]
				let	vc1	=	SlidePageViewController()
				vc1.imageItem	=	u1
				return	vc1
			}
		}
		return	nil
	}
	
	private func steppingTimerControllerOnTime() {
		let	vc	=	owner!.pageVC.viewControllers[0] as! UIViewController
		if let vc1 = pageViewController(owner!.pageVC, viewControllerAfterViewController: vc) {
			owner!.pageVC.setViewControllers([vc1], direction: UIPageViewControllerNavigationDirection.Forward, animated: true) { (cancel:Bool) -> Void in
				
			}
		}
	}
}

















private func sortRandomly<T>(us:[T]) -> [T] {
	var	us1	=	us
	for i in 0..<us.count {
		let	i1	=	Int(arc4random_uniform(UInt32(us.count)))
		swap(&us1[i], &us1[i1])
	}
	return	us1
}













private protocol SteppingTimerControllerDelegate: class {
	func steppingTimerControllerOnTime()
}
private final class SteppingTimerController {
	weak var delegate:SteppingTimerControllerDelegate?
	
	init() {
		timer				=	NSTimer.scheduledTimerWithTimeInterval(DEFAULT_TIMEOUT, target: timerDelegate, selector: "onTime:", userInfo: nil, repeats: false)
		timerDelegate.owner	=	self
	}
	deinit {
		timer.invalidate()
	}
	
	func resetWaitingTime() {
		timer.invalidate()
		timer	=	NSTimer.scheduledTimerWithTimeInterval(DEFAULT_TIMEOUT, target: timerDelegate, selector: "onTime:", userInfo: nil, repeats: false)
	}
	
	private var	timer: NSTimer
	private let	timerDelegate	=	TimerDelegate()
	
	@objc
	private class TimerDelegate: NSObject {
		weak var owner:SteppingTimerController?
		@objc
		func onTime(AnyObject?) {
			Debug.log("onTime")
			owner!.delegate!.steppingTimerControllerOnTime()
			owner!.resetWaitingTime()
		}
	}
	
	private let	DEFAULT_TIMEOUT	=	NSTimeInterval(3)
}









