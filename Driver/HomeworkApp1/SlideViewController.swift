////
////  SlidingViewController.swift
////  HomeworkApp1UIComponents
////
////  Created by Hoon H. on 2015/02/26.
////
////
//
//import Foundation
//import UIKit
//
//
//
/////	Set `imageURLs` to specify whole data set.
/////	
/////	Data flows in this order.
/////
/////	1.	planURLQueue
/////	2.	trasmittingURLs
/////	3.	futureImageQueue
/////	4.	displayingImages
/////	5.	pastImageQueue
/////
/////	This will load future URLs SEQUENTIALLY one by one.
/////	Loaded image will be enqueued into `futureImageQueue` and the URL will be removed from `futureURLQueue`.
/////	(URLs will not be removed from the URL queue until it to be loaded)
/////
/////
/////
/////	TODO:
/////	Scrolling sometimes breaks when rotating device orientation.
/////	Fixing this will take huge time, so I just skip this in this release.
//final class SlideViewController: UIViewController {
//	deinit {
//		assert(timer == nil)
//	}
//	
//	///	Queued images will be trigger to be loaded immediately without extra method call.
//	func queueImageURLs(urls:[NSURL]) {
//		planURLQueue.extend(urls)
//		stepLoadingPlannedImage()
//	}
//	
//	var scrollView:UIScrollView {
//		get {
//			return	view as! UIScrollView
//		}
//	}
//	
//	override func loadView() {
//		super.view	=	UIScrollView()
//	}
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		scrollView.pagingEnabled	=	true
//		imageViews.map(scrollView.addSubview)
//		for i in 0..<3 {
//			imageViews[i].backgroundColor	=	UIColor.brownColor().colorWithAlphaComponent(CGFloat(i+1) / 3)
//		}
//		
//		////
//		
//		scrollView.delegate			=	reactions
//		reactions.owner				=	self
//	}
//	override func viewWillLayoutSubviews() {
//		super.viewWillLayoutSubviews()
//		
//		let	b	=	scrollView.bounds
//		scrollView.contentSize	=	CGSize(width: b.width * 3, height: b.height)
//		
//		for i in 0..<imageViews.count {
//			let	x	=	CGFloat(i) * b.width
//			let	v	=	imageViews[i]
//			v.frame	=	CGRect(x: x, y: 0, width: b.width, height: b.height)
//		}
//	}
//	
//	
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//		
//		scrollView.setContentOffset(contentPointForPageIndex(1), animated: false)
//	}
//	override func viewWillDisappear(animated: Bool) {
//		super.viewWillDisappear(animated)
//		if timer != nil {
//			cancelWaitingForIdleTimeoue()
//		}
//	}
//	
//	///	Called before rotation state changes.
//	override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
//		assert(fromIndex == nil)
//		
//		super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
//		fromIndex	=	pageIndexEstimation
//	}
//	
//	///	Called after rotation state changed.
//	override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
//		assert(fromIndex != nil)
//		super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
//		
//		let	b	=	scrollView.bounds
//		let	p	=	CGFloat(fromIndex!) * b.width
//		scrollView.contentOffset	=	CGPoint(x: p, y: 0)
//		
//		fromIndex	=	nil
//	}
//	
//	override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
//		super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
//		
//		let	b	=	scrollView.bounds
//		let	p	=	CGFloat(pageIndexEstimation) * b.width
//		scrollView.contentOffset	=	CGPoint(x: p, y: 0)
//		
//		fromIndex	=	nil
//	}
//	
//	////
//	
//	private var	pastImageQueue		=	[] as [UIImage]		//	Up to 3 image.
//	private var displayingImages	=	[] as [UIImage]		//	Always 0~3 objects.
//	private var	futureImageQueue	=	[] as [UIImage]
//	private var	trasmittingURLs		=	[] as [NSURL]		//	Always 0~1 objects.
//	private var	planURLQueue		=	[] as [NSURL]
//	
//	private let	reactions			=	ReactionController()
//	private let	imageViews			=	[UIImageView(), UIImageView(), UIImageView()]
//	
//	private var	fromIndex			=	nil as Int?
//	private var	timer				=	nil as NSTimer?
//	
//	///	Resolves estimated page index based on current scrolling offset.
//	private var pageIndexEstimation:Int {
//		get {
//			let	b	=	scrollView.bounds
//			let	p	=	scrollView.contentOffset.x
//			let	idx	=	Int(round(p / b.width))
//			return	idx
//		}
//	}
//	private func contentPointForPageIndex(index:Int) -> CGPoint {
//		let	b	=	scrollView.bounds
//		let	x	=	b.width * CGFloat(index)
//		return	CGPoint(x: x, y: 0)
//	}
//}
//
//
//
//
//
//
//private extension SlideViewController {
//	func stepLoadingPlannedImage() {
//		assert(planURLQueue.count > 0)
//		println("stepLoadingPlannedImage, planURLQueue.count = `\(planURLQueue.count)`.")
//		
//		let	u	=	planURLQueue.removeAtIndex(0)
//		dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) { [weak self] in
//			if let d = NSData(contentsOfURL: u), let m = UIImage(data: d) {
//				dispatch_async(dispatch_get_main_queue()) {
//					if let me = self {
//						println("Loaded image at URL `\(u)`, timer = `\(me.timer)`.")
//						me.futureImageQueue.append(m)
//						
//						if me.timer == nil {
//							me.waitForIdleTimeout()
//						}
//					}
//				}
//			} else {
//				//	Loading failed.
//				dispatch_async(dispatch_get_main_queue()) {
//					UIAlertView(title: nil, message: "Couldn't load image.", delegate: nil, cancelButtonTitle: "OK").show()
//				}
//			}
//		}
//	}
//}
//
//private extension SlideViewController {
//	func waitForIdleTimeout() {
//		assert(timer == nil)
//		assert(futureImageQueue.count > 0)
//		
//		timer	=	NSTimer.scheduledTimerWithTimeInterval(IMAGE_READY_AND_IDLE_TIMEOUT_SECONDS, target: reactions, selector: "timerDidFire:", userInfo: nil, repeats: false)
//	}
//	func cancelWaitingForIdleTimeoue() {
//		assert(timer != nil)
//		timer!.invalidate()
//		timer	=	nil
//	}
//}
//
//private extension SlideViewController {
//	///	Called when a new image available.
//	///	Pushes new image into display-image set,
//	///	and fills image-view slots from back to front.
//	///	Extra image (old one) will be popped if exists.
//	///
//	///
//	func shiftImagesToLeft() {
//		assert(displayingImages.count <= imageViews.count)
//		assert(futureImageQueue.count > 0, "This must be called only when `futureImageQueue` contains some images.")
//		assert(pageIndexEstimation == 2, "Page index estimation of `2` expected, but is `\(pageIndexEstimation)`.")
//		////
//		
//		if let m = futureImageQueue.first {
//			futureImageQueue.removeAtIndex(0)
//			displayingImages.append(m)
//		}
//		
//		////
//		
//		while displayingImages.count > imageViews.count {
//			let	m	=	displayingImages.first!
//			displayingImages.removeAtIndex(0)
//			pastImageQueue.append(m)
//		}
//		while pastImageQueue.count > 3 {
//			pastImageQueue.removeAtIndex(0)
//		}
//		
//		let	dt	=	imageViews.count - displayingImages.count
//		for i in 0..<dt {
//			let	v	=	imageViews[i]
//			v.image	=	nil
//		}
//		for i in 0..<(imageViews.count-dt) {
//			let	v	=	imageViews[i+dt]
//			let	m	=	displayingImages[i]
//			v.image	=	m
//		}
//		
//		scrollView.setContentOffset(contentPointForPageIndex(1), animated: false)
//	}
//	
//	func shiftImagesToRight() {
//		assert(pageIndexEstimation == 0, "Page index estimation of `0` expected, but is `\(pageIndexEstimation)`.")
//		
//		if let m = imageViews[2].image {
//			futureImageQueue.insert(m, atIndex: 0)
//			imageViews[2].image	=	nil
//		}
//		for i in 0..<(imageViews.count-1) {
//			imageViews[i+1].image	=	imageViews[i].image
//		}
//		imageViews[0].image	=	pastImageQueue.last
//		if let _ = pastImageQueue.last {
//			pastImageQueue.removeLast()
//		}
//		
//		scrollView.setContentOffset(contentPointForPageIndex(1), animated: false)
//	}
//}
//
//
//
//
//
//
//@objc
//private final class ReactionController: NSObject, UIScrollViewDelegate {
//	weak var owner: SlideViewController?
//	
//	@objc
//	func timerDidFire(AnyObject?) {
//		owner!.timer	=	nil
//		
//		let	i	=	owner!.pageIndexEstimation + 1
//		let	p	=	owner!.contentPointForPageIndex(i)
//		println("timerDidFire, switching to page `\(i)`.")
//		owner!.scrollView.setContentOffset(p, animated: true)
//	}
//	
//	@objc
//	private func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//		println("scrollViewWillBeginDragging")
//		if let _ = owner!.timer {
//			owner!.cancelWaitingForIdleTimeoue()
//		}
//	}
//	
//	@objc
//	func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//		println("scrollViewDidEndDragging")
//	}
//	
//	///	Scrolling triggered by user dragging finished.
//	@objc
//	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//		println("scrollViewDidEndDecelerating")
//		
//		while owner!.pageIndexEstimation > 1 {
//			owner!.shiftImagesToRight()
//		}
//		while owner!.pageIndexEstimation < 1 {
//			owner!.shiftImagesToLeft()
//		}
//		
//		if owner!.futureImageQueue.count > 0 {
////			println("start idle waiting.")
////			owner!.waitForIdleTimeout()
//		}
//	}
//	
//	///	Scrolling triggered by programmatic call (such as `setContentOffset(, animated:)`) finished.
//	@objc
//	func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
//		println("scrollViewDidEndScrollingAnimation")
//		
//		owner!.shiftImagesToLeft()
//		if owner!.planURLQueue.count > 0 {
//			owner!.stepLoadingPlannedImage()
//		}
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
//
//
//
//private let	IMAGE_READY_AND_IDLE_TIMEOUT_SECONDS	=	NSTimeInterval(1)
//
//
//
//
