//
//  Client.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import UIKit

struct Client {
	static func fetchImageAtURL(url:NSURL, handler:(image:UIImage?)->()) -> Transmission {
		Debug.log("fetchImageAtURL with url `\(url)`.")
		let	t	=	NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (d:NSData!, r:NSURLResponse!, e:NSError!) -> Void in
			if d == nil {
				handler(image: nil)
				return
			}
			if e != nil {
				handler(image: nil)
				return
			}
			
			let	m	=	UIImage(data: d!)
			if m == nil {
				handler(image: nil)
				return
			}
			
			handler(image: m)
		})
		
		Debug.log("Download OK for url `\(url)`.")
		t.resume()
		return	Transmission() {
			t.cancel()
		}
	}
}


///	Abstracts network I/O operation.
///	Provides cancellation.
final class Transmission {
	init(cancellation: ()->()) {
		self.cancellation	=	cancellation
	}
	deinit {
		self.cancel()
	}
	func cancel() {
		cancellation()
	}
	
	////
	
	private let cancellation:()->()
}

