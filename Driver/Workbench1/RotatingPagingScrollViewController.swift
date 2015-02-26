////
////  RotatingPagingScrollViewController.swift
////  HomeworkApp1
////
////  Created by Hoon H. on 2015/02/26.
////
////
//
//import Foundation
//import UIKit
//
//class RotatingPagingScrollViewController: ScrollViewController {
//	var	pageCount:Int {
//		didSet {
//			view.setNeedsLayout()
//			view.layoutIfNeeded()
//		}
//	}
//	///	Resolves estimated page index based on current scrolling offset.
//	var pageIndexEstimation:Int {
//		get {
//			let	b	=	scrollView.bounds
//			let	p	=	scrollView.contentOffset.x
//			let	idx	=	Int(round(p / b.width))
//			return	idx
//		}
//	}
//	func contentPointForPageIndex(index:Int) -> CGPoint {
//		let	b	=	scrollView.bounds
//		let	x	=	b.width * CGFloat(index)
//		return	CGPoint(x: x, y: 0)
//	}
//	
//	////
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		scrollView.pagingEnabled	=	true
//	}
//	
//	override func viewWillLayoutSubviews() {
//		super.viewWillLayoutSubviews()
//		
//		let	b	=	scrollView.bounds
//		scrollView.contentSize	=	CGSize(width: b.width * pageCount, height: b.height)
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
//	private var	fromIndex			=	nil as Int?
//}
//
//
//
//
//
