//
//  Debug.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation

struct Debug {
	static func log<T>(@autoclosure value:()->T) {
		println(value())
	}
	static func assertMainThread() {
		assert(NSThread.currentThread() == NSThread.mainThread())
	}
}