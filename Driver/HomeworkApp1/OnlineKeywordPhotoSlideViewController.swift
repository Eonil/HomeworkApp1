////
////  OnlineKeywordPhotoSlideViewController.swift
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
//
/////	You must set `keywordData` before this object to be appears.
//final class OnlineKeywordPhotoSlideViewController: UIViewController {
//	
//	var	keywordData:String? {
//		didSet {
//			listing?.cancel()
//			if let s = keywordData {
//				listing	=	Client.fetchImageURLs(s, completion: { [unowned self](imageURLs) -> () in
//					//	It's a logic bug if this is called after `self` deallocated.
//					assert(imageURLs != nil, "Error while loading image URLs.")
//					dispatch_async(dispatch_get_main_queue()) {
//						assert(NSThread.mainThread() == NSThread.currentThread())
//						
//						println("URL loaded.")
//						if let us = imageURLs {
//							self.core.imageURLs	=	us
//						} else {
//							self.core.imageURLs	=	[]
//						}
//					}
//				})
//			}
//		}
//	}
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//	}
//	override func viewWillAppear(animated: Bool) {
//		assert(keywordData != nil, "You must set `keywordData` before this object to be appears.")
//		super.viewWillAppear(animated)
//	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//	}
//	override func viewWillDisappear(animated: Bool) {
//		super.viewWillDisappear(animated)
//		listing?.cancel()
//		listing	=	nil
//	}
//	override func viewDidDisappear(animated: Bool) {
//		super.viewDidDisappear(animated)
//	}
//	
//	////
//	
//	private var	listing		=	nil as Transmission?
//	private let	core		=	PhotoSlideViewController()
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
