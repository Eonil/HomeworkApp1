//
//  ApplicationController.swift
//  HomeworkApp1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import UIKit

@objc
@UIApplicationMain
class ApplicationController: UIResponder, UIApplicationDelegate {
	private let window		=	UIWindow(frame: UIScreen.mainScreen().bounds)
	private let navigation	=	UINavigationController()
	private let	input		=	KeyworkdInputFormViewController()
}

extension ApplicationController: UIApplicationDelegate {
	
	@objc
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window.makeKeyAndVisible()
		
		window.rootViewController	=	navigation
		
		navigation.pushViewController(input, animated: false)
		
		return true
	}
	
	@objc
	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}
	
	@objc
	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	@objc
	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}
	
	@objc
	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	@objc
	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}