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
	struct ImageItem {
		var	title:String
		var	URL:NSURL
	}
	
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
	static func fetchImageURLs(keyword:String, completion:(imageItems:[ImageItem]?)->()) -> Transmission {
		return	fetchImageURL(keyword, continuation: nil, completion: completion)
	}
	
	
	
	
	static func fetchImageURL(keyword:String, continuation:Continuation?, completion:(imageItems:[ImageItem]?)->()) -> Transmission {
		var	f	=	[
			"v"			:	"1.0",
			"q"			:	keyword,
			"rsz"		:	"8",
			"imgtype"	:	"photo",
		]
		if let c = continuation {
			f["start"]	=	c.start
		}
		
		let	qs	=	HTML.Form.URLEncoded.encode(f)
		let	u	=	NSURL(string: REQ_URL.stringByAppendingString(qs))!
		let	t	=	NSURLSession.sharedSession().dataTaskWithURL(u, completionHandler: { (d:NSData!, r:NSURLResponse!, e:NSError!) -> Void in
			if d == nil {
				Debug.log("Client.fetchImageURL download failed with no error and no data for URL `\(u)`.")
				completion(imageItems: nil)
				return
			}
			if e != nil {
				if e!.domain == NSURLErrorDomain {
					if e!.code == NSURLErrorCancelled {
						//	Cancelled intentionally.
						Debug.log("Client.fetchImageURL download from URL `\(u)` cancelled intentionally.")
						return
					}
				}
				
				Debug.log("Client.fetchImageURL download error while downloading URL `\(u)`: \(e)")
				completion(imageItems: nil)
				return
			}
		
			let	j	=	JSON.deserialise(d!)
			if j == nil {
				Debug.log("Client.fetchImageURL downloaded `\(d.length) bytes` from URL `\(u)`, but the data is not a decodable image.")
				completion(imageItems: nil)
				return
			}
			
			let	v	=	API.Response(json: j!, errorTrap: { (err:String) -> () in
				assert(false, err)
			})
			if v == nil {
				completion(imageItems: nil)
				return
			}
			
			func toItem(m:API.Response.ResponseData.ResultItem) -> ImageItem? {
				if let u = NSURL(string: m.url) {
					return	ImageItem(title: m.titleNoFormatting, URL: u)
				}
				return	nil
			}
			let	ms	=	v!.responseData.results.map(toItem)
			for m in ms {
				if m == nil {
					completion(imageItems: nil)
					return
				}
			}
			let	ms1	=	ms.map({ u in u! })
			
			////
			
			
			Debug.log(ms1)
			completion(imageItems: ms1)
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
















///	Hardcoded for quick implementation.
///	Usage:
///
///		"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=moe"
///
private let	REQ_URL	=	"https://ajax.googleapis.com/ajax/services/search/images?"

