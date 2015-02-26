//
//  Operators.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/27.
//
//

import Foundation

infix operator ||| {
}

func ||| <T> (left:T?, right:T) -> T {
	if let v = left {
		return	v
	}
	return	right
}