//
//  SwitchingView.swift
//  HomeworkApp1UIComponents
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

///	Set left/right view and switching ratio.
final class SwitchingView: UIView {
	
	var	leftView:UIView? = nil {
		didSet {
			
		}
	}
	var rightView:UIView? = nil {
		didSet {
			
		}
	}
	
	///	0~1 value.
	///	0 means left view is fully visible.
	///	1 means right view is fully visible.
	var	switchingRatio:CGFloat = 0.0 {
		didSet {
			
		}
	}
}