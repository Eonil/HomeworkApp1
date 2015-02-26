//
//  CV1.swift
//  HomeworkApp1UIComponents
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

class CV1: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	override convenience init() {
		let	l	=	UICollectionViewFlowLayout()
		l.scrollDirection	=	UICollectionViewScrollDirection.Horizontal
		self.init(collectionViewLayout: l)
	}
	
	var	flowLayout:UICollectionViewFlowLayout {
		get {
			return	self.collectionViewLayout as! UICollectionViewFlowLayout
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "CELL")
		self.collectionView!.pagingEnabled	=	true
	}
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return	1
	}
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return	3
	}
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let	v	=	collectionView.dequeueReusableCellWithReuseIdentifier("CELL", forIndexPath: indexPath) as! UICollectionViewCell
		v.backgroundColor	=	UIColor.brownColor().colorWithAlphaComponent(CGFloat(indexPath.row + 1) / 3)
		return	v
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return	UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return	0
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return	0
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		println("func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {")
		return	self.view.bounds.size
	}
	
//	override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
//		super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
//
	override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
		super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
		
		collectionView!.collectionViewLayout.invalidateLayout()
	}
	override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
		super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
//		collectionView!.performBatchUpdates(nil, completion: nil)
	}
	
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		collectionView!.collectionViewLayout.invalidateLayout()
	}
}