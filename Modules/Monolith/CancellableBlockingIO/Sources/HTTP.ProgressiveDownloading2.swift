//
//  HTTP.ProgressiveDownloading2.swift
//  EonilCancellableBlockingIO
//
//  Created by Hoon H. on 11/8/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Foundation


extension HTTP {
	
	
	///	Progressive downloading context.
	///
	///	1.	Call `progress()` until it returns `Done`.
	///	2.	Call `complete()` to query final state.
	///
	///	Step 1 can be omitted if you don't want a progress.
	///	Stepping calls will be blocked using semaphores until meaningful result
	///	comes up.
	///
	///	This uses `NSURLSession` internally.
	public final class ProgressiveDownloading2 {
		
		public enum Progress {
			case Continue(range:Range<Int64>, total:Range<Int64>?)
			case Done
		}
		
		public enum Complete {
			case Cancel
			case Error(message:String)
			case Ready(file:NSURL)
		}
		
		public let	progress:()->Progress
		public let	complete:()->Complete
		
		init(address:NSURL, cancellation:Trigger) {
			if cancellation.state {
				progress	=	{ return Progress.Done }
				complete	=	{ return Complete.Cancel }
				return
			}
			
			let	pal1	=	Palette()
			var	fcmpl1	=	false
			
			let	conf1	=	nil as NSURLSessionConfiguration?
			let	dele1	=	DownloadController(pal1)
			let	sess1	=	NSURLSession(configuration: conf1,delegate: dele1, delegateQueue: defaultDownloadingQueue())
			let	task1	=	sess1.downloadTaskWithURL(address)
			
			let watc1	=	cancellation.watch {
				task1.cancel()
			}
			
			progress	=	{ ()->Progress in
				precondition(fcmpl1 == false, "You cannot call this function for once completed downloading.")
				let	v1	=	pal1.progressChannel.wait()
				return	v1
			}
			complete	=	{ [watc1]()->Complete in			///	Keep watch until finishes.
				let	v1	=	pal1.completionChannel.wait()
				fcmpl1	=	true
				return	v1
			}
			task1.resume()
		}
	}
}











extension HTTP.ProgressiveDownloading2.Complete: Printable {
	public var ready:NSURL? {
		get {
			switch self {
			case let .Ready(s):	return	s
			default:			return	nil
			}
		}
	}
	
	public var description:String {
		get {
			switch self {
			case Cancel:		return	"Cancel"
			case Error(let s):	return	"Error(\(s.message))"
			case Ready(let s):	return	"Ready(\(s.file))"
			}
		}
	}
}



























///	MARK:
///	MARK:	Implementation Details
///	MARK:



private class Palette {
	typealias	Progress	=	HTTP.ProgressiveDownloading2.Progress
	typealias	Complete	=	HTTP.ProgressiveDownloading2.Complete
	
	let	progressChannel		=	Channel<Progress>()
	let	completionChannel	=	Channel<Complete>()
}




private func defaultDownloadingQueue() -> NSOperationQueue {
	struct Slot {
		static let	value	=	NSOperationQueue()
	}
	Slot.value.qualityOfService	=	NSQualityOfService.Background
	return	Slot.value
}




///	All the delegate methods should be called from another thread.
///	Otherwise, it's deadlock.
private final class DownloadController: NSObject, NSURLSessionDelegate, NSURLSessionDownloadDelegate {
	typealias	Progress	=	HTTP.ProgressiveDownloading2.Progress
	typealias	Complete	=	HTTP.ProgressiveDownloading2.Complete
	
	let	palette:Palette
	init(_ palette:Palette) {
		self.palette	=	palette
	}
	@objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
		self.palette.progressChannel.signal(Progress.Done)
		self.palette.completionChannel.signal(Complete.Ready(file: location))
	}
	private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
		
	}
	private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		let	r1	=	Range<Int64>(start: totalBytesWritten-bytesWritten, end: totalBytesWritten)
		let	r2	=	totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown ? nil : Range<Int64>(start: 0, end: totalBytesExpectedToWrite) as Range<Int64>?
		self.palette.progressChannel.signal(Progress.Continue(range: r1, total: r2))
	}
	private func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
		self.palette.progressChannel.signal(Progress.Done)
		self.palette.completionChannel.signal(Complete.Error(message: error == nil ? "Unknown error" : error!.description))
	}
	private func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
		self.palette.progressChannel.signal(Progress.Done)
		self.palette.completionChannel.signal(Complete.Error(message: error == nil ? "Unknown error" : error!.description))
	}
}


