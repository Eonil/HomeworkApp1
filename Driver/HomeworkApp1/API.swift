//
//  API.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation


struct API {
	
}

///	Existence of all fields are guaranteed unless marked as *optional*.
///	Unnecessary fields are omitted.
extension API {
	struct Response {
		var	responseData:ResponseData
		
		struct ResponseData {
			var	results:[ResultItem]
			
			struct ResultItem {
				var	titleNoFormatting:String
				var	url:String
			}
		}
	}
}


