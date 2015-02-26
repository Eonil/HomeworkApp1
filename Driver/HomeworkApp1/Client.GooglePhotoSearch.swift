//
//  Networking.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import Standards





///	Google Photo search API service.
///	https://developers.google.com/image-search/v1/jsondevguide#basic
///
///	Almost the only sane API documentation I could ever found.
extension Client {
	
	///	Fetches a few of arbitrary image list.
	///
	///
	///	:param:	completion
	///			Called at transmission completion regardless success or failure.
	///		
	///			:param:	imageURLs
	///					Fetched image URL list.
	///					`nil` on any error.
	///
	///	If you `cancel` the returning `Transmission`, `completion` will not be called.
	static func fetchImageURLs(keyword:String, completion:(imageURLs:[NSURL]?)->()) -> Transmission {
		return	fetchImageURL(keyword, continuation: nil, completion: completion)
	}
	
	
	
	
	static func fetchImageURL(keyword:String, continuation:Continuation?, completion:(imageURLs:[NSURL]?)->()) -> Transmission {
		var	f	=	[
			"v"		:	"1.0",
			"q"		:	keyword,
			"rsz"	:	"8",
		]
		if let c = continuation {
			f["start"]	=	c.start
		}
		
		let	qs	=	HTML.Form.URLEncoded.encode(f)
		let	u	=	NSURL(string: REQ_URL.stringByAppendingString(qs))!
		let	t	=	NSURLSession.sharedSession().dataTaskWithURL(u, completionHandler: { (d:NSData!, r:NSURLResponse!, e:NSError!) -> Void in
			if d == nil {
				Debug.log("No error, and no data for URL `\(u)`.")
				completion(imageURLs: nil)
				return
			}
			if e != nil {
				Debug.log("Error while downloading URL `\(u)`: \(e)")
				completion(imageURLs: nil)
				return
			}
		
			let	j	=	JSON.deserialise(d!)
			if j == nil {
				Debug.log("Error while decoding JSON from URL `\(u)`")
				completion(imageURLs: nil)
				return
			}
			
			let	v	=	API.Response(json: j!, errorTrap: { (err:String) -> () in
				assert(false, err)
			})
			if v == nil {
				completion(imageURLs: nil)
				return
			}
			
			let	us	=	v!.responseData.results.map({ m in NSURL(string: m.url) })
			for u in us {
				if u == nil {
					completion(imageURLs: nil)
					return
				}
			}
			let	us1	=	us.map({ u in u! })
			
			////
			
			
			Debug.log(us1)
			completion(imageURLs: us1)
		})
		
		t.resume()
		return	Transmission {
			t.cancel()
		}
	}
	
	
	
	struct Continuation {
		private var start:String
	}
}

















private func sortRandomly(us:[NSURL]) -> [NSURL] {
	var	us1	=	us
	for i in 0..<us.count {
		let	i1	=	Int(arc4random_uniform(UInt32(us.count)))
		swap(&us1[i], &us1[i1])
	}
	return	us1
}



///	Hardcoded for quick implementation.
///	Usage:
///
///		"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=moe"
///
private let	REQ_URL	=	"https://ajax.googleapis.com/ajax/services/search/images?"

