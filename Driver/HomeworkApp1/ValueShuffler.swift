//
//  ValueShuffler.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/27.
//
//

import Foundation

final class ValueShuffler<T:Equatable> {
	internal private(set) var	sequence		=	[] as [T]
	private var					sourcePool		=	[] as [T]
	
	////
	
	var	maximumSequenceCount:Int = 8 {
		willSet(v) {
			assert(v >= 8)
		}
		didSet {
			applySequenceCountLimit()
		}
	}
	
	func applySequenceCountLimit() {
		while sequence.count > maximumSequenceCount {
			sequence.removeAtIndex(0)
		}
	}
	
	func continueSequence() {
		sequence.append(selectRandom())
		applySequenceCountLimit()
	}
	
	func pushSourcePoolValues(vs:[T]) {
		sourcePool.extend(vs)
	}
	
	
	
	
	
	
	
	private func selectRandom() -> T {
		return	selectRandomCore(0)
	}
	
	private func selectRandomCore(depthLimit:Int) -> T {
		let	i	=	Int(arc4random_uniform(UInt32(sourcePool.count)))
		let	v	=	sourcePool[i]
		if depthLimit < 4 {
			if let l = sourcePool.last {
				if l == v {
					return	selectRandomCore(depthLimit + 1)
				}
			}
		}
		return	v
	}
}
