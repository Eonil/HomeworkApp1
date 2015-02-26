////
////  PhotoSlideViewController.swift
////  HomeworkApp1
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
/////	Displays and manages manual scrolling of photo slides.
/////
/////
/////	TODO:
/////	Scrolling sometimes breaks when rotating device orientation.
/////	Try `UICollectionView` based scrolling. Seems to be easier.
//final class PhotoSlideViewController: UIViewController {
//	///	Setting this property will trigger clearing and reloading of all image contents.
//	var	imageURLs:[NSURL] = [] {
//		didSet {
//			imageViews.map({ v in v.removeFromSuperview() })
//			
//			func makeView(image:UIImage) -> UIImageView {
//				let	v	=	UIImageView()
//				v.image	=	image
//				v.contentMode	=	UIViewContentMode.ScaleAspectFill
//				v.clipsToBounds	=	true
//				return	v
//			}
//			
//			//	TOOD:	Optimise to use asynchronous loading.
//			let	ds		=	imageURLs.map({ u in NSData(contentsOfURL: u)! })
//			let	ms		=	ds.map({ d in UIImage(data: d)! })
//			imageViews	=	ms.map({ m in makeView(m) })
//			imageViews.map(self.view.addSubview)
//			
//			println("images loaded.")
//		}
//	}
//	var scrollView:UIScrollView {
//		get {
//			return	view as! UIScrollView
//		}
//	}
//	
//	////
//	
//	override func loadView() {
//		super.view					=	UIScrollView()
//	}
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		scrollView.pagingEnabled					=	true
//		scrollView.showsHorizontalScrollIndicator	=	false
//		scrollView.showsVerticalScrollIndicator		=	false
//	}
////	override func viewWillAppear(animated: Bool) {
////		super.viewWillAppear(animated)
////	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//		
//		timer	=	NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "timerDidFire:", userInfo: nil, repeats: true)
//	}
//	override func viewWillDisappear(animated: Bool) {
//		super.viewWillDisappear(animated)
//		
//		timer!.invalidate()
//		timer	=	nil
//	}
////	override func viewDidDisappear(animated: Bool) {
////		super.viewDidDisappear(animated)
////	}
//	override func viewWillLayoutSubviews() {
//		super.viewWillLayoutSubviews()
//		
//		let	b	=	view.bounds
//		let	w	=	b.width * CGFloat(imageViews.count)
//		let	h	=	b.height
//		self.scrollView.contentSize	=	CGSize(width: w, height: h)
//		
//		for i in 0..<imageURLs.count {
//			let	x	=	CGFloat(i) * b.width
//			let	y	=	b.minY
//			let	w	=	b.width
//			let	h	=	b.height
//			let	f	=	CGRect(x: x, y: y, width: w, height: h)
//			let	v	=	imageViews[i]
//			v.frame	=	f
//		}
//	}
//
//	///	Called before rotation state changes.
//	override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
//		assert(fromIndex == nil)
//		super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
//		
//		fromIndex	=	currentPageIndexEstimation
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
//		let	p	=	CGFloat(currentPageIndexEstimation) * b.width
//		scrollView.contentOffset	=	CGPoint(x: p, y: 0)
//		
//		fromIndex	=	nil
//	}
//
//	@objc
//	func timerDidFire(AnyObject?) {
//		let	idx	=	currentPageIndexEstimation
//		let	i1	=	idx + 1
//		let	p	=	contentPointForPageIndex(i1)
//		scrollView.setContentOffset(p, animated: true)
//	}
//	
//	////
//	
//	private var	imageViews	=	[] as [UIImageView]
//	private var	fromIndex	=	nil as Int?
//	private var	timer		=	nil as NSTimer?
//	
//	///	Resolves estimated page index based on current scrolling offset.
//	private var currentPageIndexEstimation:Int {
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
//
//
//
//
//
//
//
//
//
