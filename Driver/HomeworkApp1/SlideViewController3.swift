//
//  SlideViewController3.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit


///	`queueImageURLs` to add image URL list.
///	This object will take care of everything else.
///
///	Set a close button at `navigationItem.leftBarButton`.
///	This view controller will not set anything at left bar button slot.
///
///	**Note**
///	`UIPageViewController` internalised to hide details.
final class SlideViewController3: UIViewController {
	func queueImageURLs(imageURLs:[NSURL]) {
		Debug.assertMainThread()
		
		pushImageURLs(imageURLs)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		pushImageURLs([])
		
		navigationItem.rightBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: reactions, action: "userDidTapSaveButton:")
		
		////
		
		reactions.owner		=	self
		pageVC.dataSource	=	reactions
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	////
	
	private var pastImageURLs		=	[] as [NSURL]
	private var presentImageURLs	=	[] as [NSURL]
	private var futureImageURLs		=	[] as [NSURL]
	private let pageVC				=	UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
	private let reactions			=	ReactionController()
	
	private func pushImageURLs(us:[NSURL]) {
		self.futureImageURLs.extend(us)
		if pageVC.viewControllers.count == 0 {
			if let f = futureImageURLs.first {
				let	vc	=	SlidePageViewController()
				vc.imageURL	=	f
				pageVC.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
			}
		}
	}
}



















private final class ReactionController: NSObject, UIPageViewControllerDataSource {
	weak var owner: SlideViewController3?
	
	@objc
	func userDidTapSaveButton(AnyObject?) {
	}
	
	@objc
	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		let	vc	=	viewController as! SlidePageViewController
		if let u = vc.imageURL {
			let	u	=	vc.imageURL!
			let	idx	=	find(owner!.futureImageURLs, u)!
			if idx > 0 {
				let	u1	=	owner!.futureImageURLs[idx-1]
				let	vc1	=	SlidePageViewController()
				vc1.imageURL	=	u1
				return	vc1
			}
		}
		return	nil
	}
	
	@objc
	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
		let	vc	=	viewController as! SlidePageViewController
		if let u = vc.imageURL {
			let	u	=	vc.imageURL!
			let	idx	=	find(owner!.futureImageURLs, u)!
			if idx < (owner!.futureImageURLs.count-1) {
				let	u1	=	owner!.futureImageURLs[idx+1]
				let	vc1	=	SlidePageViewController()
				vc1.imageURL	=	u1
				return	vc1
			}
		}
		return	nil
	}
}













private final class Shuffler {
	var	valuePool	=	[] as [NSURL]
	
	func pushPoolItem() {
		
	}
}










