//
//  KeywordSlideViewController.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

///	Accepts `keywordString` and download image list for it.
///	Wraps `SlideViewController3` to display them.
final class KeywordSlideViewController: UIViewController {
	var keywordString:String? {
		didSet {
			Debug.assertMainThread()
			
			transmission?.cancel()
			transmission	=	nil
			
			////
			
			if let s = keywordString {
				let	t	=	Client.fetchImageURLs(s, completion: { [unowned self](imageItems:[Client.ImageItem]?) -> () in
					dispatch_async(dispatch_get_main_queue()) {
						Debug.assertMainThread()
						
						if let vs = imageItems {
							let	us	=	vs.map({ v in v.URL })
							self.slideVC.queueImageURLs(us)
						} else {
							UIAlertView(title: nil, message: "Could not download image list.", delegate: nil, cancelButtonTitle: "Close").show()
						}
					}
				})
				
				self.transmission	=	t
			}
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.edgesForExtendedLayout					=	UIRectEdge.All
		self.extendedLayoutIncludesOpaqueBars		=	true
		self.automaticallyAdjustsScrollViewInsets	=	false
		
		self.view.addSubview(slideVC.view)
		self.addChildViewController(slideVC)
		self.view.addConstraints([
			NSLayoutConstraint(item: slideVC.view, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: slideVC.view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: slideVC.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: slideVC.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0),
			])
		
		navigationItem.rightBarButtonItem	=	slideVC.navigationItem.rightBarButtonItem
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		transmission?.cancel()
		transmission	=	nil
	}
	
	////
	
	private let	slideVC			=	SlideViewController3()
	private var transmission	=	nil as Transmission?
}

















