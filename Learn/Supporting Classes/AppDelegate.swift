//
//  AppDelegate.swift
//  Learn
//
//  Created by Mani on 10/14/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var counter = 0.0
    var timer = Timer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //Runs timer until the app goes in background/terminated
        startTimer()
        
//        print("didFinishLaunchingWithOptions")
        
        
        return true
    }
    
    func startTimer(){
        let defaults = UserDefaults.standard
        if let timeCount = defaults.value(forKey: "UsingAppTimer"){
            let time = timeCount as! Double
//            print("score \(time*60)")
            counter = time*60 //converting back to seconds
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func endTimer(){
        timer.invalidate()
//        print("counter \(counter/60)")
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(counter/60, forKey: "UsingAppTimer")
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
//        print("timerAction")
        counter += 1
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        
//        print("applicationDidEnterBackground)")
        endTimer()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //start timer again when app comes in foreground
        startTimer()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        
//        print("applicationWillTerminate")
        timer.invalidate()
//        print("counter \(counter)")
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        assert(counter > 0)
        
        //storing the time spend on app in minutes
        defaults.set(counter/60, forKey: "UsingAppTimer")
        
    }


}

