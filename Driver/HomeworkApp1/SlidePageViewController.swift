//
//  SlidePageViewController.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

protocol SlidePageViewControllerDelegate: class {
	func slidePageViewControllerWillInitiateImageLoading()
	func slidePageViewControllerDidCompleteImageLoading()
}

final class SlidePageViewController: UIViewController {
	weak var delegate:SlidePageViewControllerDelegate?
	
	var	imageURL:NSURL? {
		didSet {
			Debug.assertMainThread()
			assert(transmission == nil)
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let	act	=	UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
		act.setTranslatesAutoresizingMaskIntoConstraints(false)
		act.sizeToFit()
		self.view.addSubview(act)
		self.view.addConstraints([
			NSLayoutConstraint(item: act, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: act, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0),
			])
		
		imageView.contentMode	=	UIViewContentMode.ScaleAspectFill
		imageView.clipsToBounds	=	true
		imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.view.addSubview(imageView)
		self.view.addConstraints([
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0),
			])
		
		////
		
		if let u = imageURL {
			self.delegate?.slidePageViewControllerWillInitiateImageLoading()
			self.transmission	=	Client.fetchImageAtURL(u, handler: { [weak self](image:UIImage?) -> () in
				dispatch_async(dispatch_get_main_queue()) { [weak self] in
					Debug.assertMainThread()
					
					if let me = self {
						me.transmission	=	nil
						if let m = image {
							Debug.log("SlidePageViewController downloaded image `\(m)` from URL `\(u)`.")
							me.imageView.image	=	m
						} else {
							Debug.log("SlidePageViewController couldn't download image for URL `\(u)`.")
							UIAlertView(title: nil, message: "Could not download image.", delegate: nil, cancelButtonTitle: "Close").show()
							me.imageView.image	=	nil
						}
						me.delegate?.slidePageViewControllerDidCompleteImageLoading()
					}
				}
			})
		} else {
			imageView.image	=	nil
		}
	}
	override func viewWillDisappear(animated: Bool) {
		transmission?.cancel()
		transmission	=	nil
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	////
	
	private let	imageView		=	UIImageView()
	private var transmission	=	nil as Transmission?
}





































