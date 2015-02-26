//
//  SlidePageViewController.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

final class SlidePageViewController: UIViewController {
	var	imageURL:NSURL? {
		didSet {
			Debug.assertMainThread()
			
			transmission?.cancel()
			transmission	=	nil
			
			////
			
			if let u = imageURL {
				self.transmission	=	Client.fetchImageAtURL(u, handler: { [weak self](image:UIImage?) -> () in
					dispatch_async(dispatch_get_main_queue()) { [weak self] in
						Debug.assertMainThread()
						
						if let me = self {
							me.transmission	=	nil
							if let m = image {
								Debug.log("OK to download image `\(m)` from URL `\(u)`.")
								me.imageView.image	=	m
							} else {
								Debug.log("Couldn't download image for URL `\(u)`.")
								UIAlertView(title: nil, message: "Could not download image.", delegate: nil, cancelButtonTitle: "Close").show()
								me.imageView.image	=	nil
							}
						}
					}
				})
			} else {
				imageView.image	=	nil
			}
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let	a	=	CGFloat(abs(rand())) / CGFloat(abs(RAND_MAX)) + 0.2
		self.view.backgroundColor	=	UIColor.brownColor().colorWithAlphaComponent(a)
		
		imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.view.addSubview(imageView)
		self.view.addConstraints([
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0),
			])
	}
	override func viewWillDisappear(animated: Bool) {
		transmission?.cancel()
		transmission	=	nil
	}
	
	////
	
	private let	imageView		=	UIImageView()
	private var transmission	=	nil as Transmission?
}
















private final class IncrementalImageList {
	func fetchMore() {
		
	}
	func clear() {
		
	}
	
	var	fetchContinuation:()->()
}




















