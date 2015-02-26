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
		Debug.log("Client.fetchImageAtURL beginning with url `\(url)`.")
		let	t	=	NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (d:NSData!, r:NSURLResponse!, e:NSError!) -> Void in
			if d == nil {
				Debug.log("Client.fetchImageAtURL download failure with no error from URL `\(url)`.")
				handler(image: nil)
				return
			}
			if e != nil {
				if e!.domain == NSURLErrorDomain {
					if e!.code == NSURLErrorCancelled {
						//	Cancelled intentionally.
						Debug.log("Client.fetchImageAtURL download from URL `\(url)` cancelled intentionally.")
						return
					}
				}

				Debug.log("Client.fetchImageAtURL download error `\(e)` while downloading from URL `\(url)`.")
				handler(image: nil)
				return
			}
			
			let	m	=	UIImage(data: d!)
			if m == nil {
				Debug.log("Client.fetchImageAtURL downloaded `\(d.length) bytes` from URL `\(url)`, but data is not decodable into an image.")
				handler(image: nil)
				return
			}
			
			Debug.log("Client.fetchImageAtURL downloaded from url `\(url)` and decoded successfully into an image. All green.")
			handler(image: m)
		})
		
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

