//
//  API.Deserialisation.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import Foundation
import Standards














extension API.Response: ErrorTrappingJSONInitializable {
	init?(json: JSON.Value, errorTrap: (String) -> ()) {
		let	o	=	json.object
		if o == nil { errorTrap("Supplied `JSON.Value` should be an `Object`."); return nil }
		
		let	r1	=	o!["responseData"]
		if r1 == nil { errorTrap("Supplied `JSON.Value` should have `responseData` field."); return nil }

		let	r2	=	ResponseData(json: r1!, errorTrap: errorTrap)
		if r2 == nil { errorTrap("Could not read `ResponseData` from supplied JSON object."); return nil }
		
		self.responseData	=	r2!
	}
}

extension API.Response.ResponseData: ErrorTrappingJSONInitializable {
	init?(json: JSON.Value, errorTrap: (String) -> ()) {
		let	o	=	json.object
		if o == nil { errorTrap("Supplied `JSON.Value` should be an `Object`."); return nil }
		
		let	r1	=	o!["results"]
		if r1 == nil { errorTrap("Supplied `JSON.Value` shold have `result` field."); return nil }
	
		let	r2	=	r1!.array
		if r2 == nil { errorTrap("Supplied `JSON.Value` shold have `result` field of `JSON.Array`."); return nil }
		
		let	r3	=	r2!.map({ j in ResultItem(json: j, errorTrap: errorTrap) })
		for m in r3 {
			if m == nil { errorTrap("One or more items from JSON array could not be parsed into `ResultItem`."); return nil }
		}
		
		let	r4	=	r3.map({ m in m! })
	
		self.results	=	r4
	}
}

extension API.Response.ResponseData.ResultItem: ErrorTrappingJSONInitializable {
	init?(json: JSON.Value, errorTrap: (String) -> ()) {
		let	o	=	json.object
		if o == nil { errorTrap("Supplied `JSON.Value` should be an `Object`."); return nil }
		
		if let s = json.stringObjectFieldForName("titleNoFormatting", errorTrap: errorTrap) {
			self.titleNoFormatting	=	s
		} else {
			return	nil
		}
		
		if let s = json.stringObjectFieldForName("url", errorTrap: errorTrap) {
			self.url	=	s
		} else {
			return	nil
		}
	}
}














private extension JSON.Value {
	///	Returns `nil` for any error. (`nil` is always an error marker value, and not for replacement for `JSON.Value.Null`)
	func stringObjectFieldForName(fieldName:Swift.String, errorTrap:(Swift.String)->()) -> Swift.String? {
		if self.object == nil { errorTrap("Current object is not a `JSON.Object`."); return nil }
		
		let	v	=	self.object![fieldName]
		if v == nil { errorTrap("Current object does not have `\(fieldName)` field."); return nil }
		
		let	s	=	v!.string
		if s == nil { errorTrap("`\(fieldName)` field is not an `JSON.String` value."); return nil }
		return	s!
	}
}











protocol ErrorTrappingJSONInitializable {
	
	///	:param:	errorTrap
	///			Called immediately for any error. Execution state will be provided in debugger.
	///			You can do whatever you want. If you do nothing in here,
	///			object initilization MUST be fail and the initializer SHOULD return `nil`.
	init?(json: JSON.Value, errorTrap:(String)->())
}












