//
//  SlidingViewController.swift
//  HomeworkApp1UIComponents
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

final class SlideViewController: UIViewController {
	override func loadView() {
		super.view	=	UIScrollView()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		scrollView.pagingEnabled	=	true
		reactions.owner				=	self
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		let	b	=	scrollView.bounds
		scrollView.contentSize	=	CGSize(width: b.width * 2, height: b.height)
	}
	
	
	override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
		super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
	}
	
	
	var scrollView:UIScrollView {
		get {
			return	view as! UIScrollView
		}
	}
	
	////
	
	private var	pastImageQueue	=	[] as [UIImage]
	private var	futureURLQueue	=	[] as [NSURL]
	private let	reactions		=	ReactionController()
}





@objc
private final class ReactionController: NSObject, UIScrollViewDelegate {
	weak var owner: SlideViewController?
	@objc
	func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
		println("scrollViewDidEndScrollingAnimation")
	}
}







//private protocol SerialImageLoadingQueueDelegate: class {
//	func didImageLoadingComplete(m:UIImage?)
//}
//
//private class SerialImageLoadingQueue {
//	weak var delegate:SerialImageLoadingQueueDelegate?
//	
//	deinit {
//		transmissions.map({ t in t.cancel() })
//		transmissions	=	[]
//	}
//	func queueImageAtURL(u:NSURL) {
//		Client.fetchImageAtURL(u, handler: { (image:UIImage?) -> () in
//			dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//				self.transmissions	=	self.transmissions.filter(<#includeElement: (T) -> Bool##(T) -> Bool#>)
//				self.delegate!.didImageLoadingComplete(image)
//			}
//		})
//	}
//	
//	private var	transmissions	=	[] as [Transmission]
//}





