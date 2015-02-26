//
//  VC1.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit


func makeVC() -> UIViewController {
	let	vc	=	UIViewController()
	vc.view.backgroundColor	=	UIColor.brownColor()
	return	vc
}
func makeVC1() -> UIViewController {
	let	vc	=	UIViewController()
	vc.view.backgroundColor	=	UIColor.magentaColor()
	return	vc
}


class VC3: UIViewController {
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
		
		pageVC.dataSource	=	reactions
		pageVC.setViewControllers([reactions.vcs.first!], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
		for g in pageVC.gestureRecognizers {
			self.view.addGestureRecognizer(g as! UIGestureRecognizer)
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

	}
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	////
	
	private let pageVC		=	UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
	private let reactions	=	ReactionController()
}





private final class ReactionController: NSObject, UIPageViewControllerDataSource {
	let	vcs	=	[
		makeVC(),
		makeVC1(),
		makeVC(),
		makeVC1(),
		makeVC(),
	]
	
	@objc
	func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
		return	vcs.count
	}
	@objc
	func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
		return	0
	}
	
	@objc
	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		if let idx = find(vcs, viewController) {
			if idx > 0 {
				return	vcs[idx-1]
			}
		}
		
		return	nil
	}
	@objc
	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
		if let idx = find(vcs, viewController) {
			if idx < (vcs.count-1) {
				return	vcs[idx+1]
			}
		}
		
		return	nil
	}
}

