//
//  AppDelegate.swift
//  Workbench1
//
//  Created by Hoon H. on 2015/02/26.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window	=	UIWindow(frame: UIScreen.mainScreen().bounds) as UIWindow?
	

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		let	u1			=	NSBundle.mainBundle().URLForResource("a", withExtension: "jpg")!
		let	u2			=	NSBundle.mainBundle().URLForResource("b", withExtension: "jpg")!
		let	u3			=	NSBundle.mainBundle().URLForResource("c", withExtension: "jpg")!
		let	u4			=	NSBundle.mainBundle().URLForResource("d", withExtension: "png")!
		let	u5			=	NSBundle.mainBundle().URLForResource("e", withExtension: "gif")!
		let	us			=	[u1, u2, u3, u4, u5]
		let	ms			=	us.map({ u in Client.ImageItem(title: "Test1", URL:u) })
		
		let	nc			=	UINavigationController()
		let	vc			=	SlideViewController3()
		nc.pushViewController(vc, animated: false)
		vc.queueImageItems(ms)
		window!.makeKeyAndVisible()
		window!.rootViewController	=	nc
		
		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

