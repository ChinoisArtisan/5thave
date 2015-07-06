//
//  AppDelegate.swift
//  FifthAve
//
//  Created by Johnny on 5/11/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, NSURLConnectionDataDelegate {

    var window: UIWindow?
    private  var home = ContainerViewController()
    private var welcome = FifthWelcomeVC()
    let navigationController = UINavigationController()
    private var firstLaunch = true
    let defaults = NSUserDefaults.standardUserDefaults()
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //  Parse
        Parse.enableLocalDatastore()
        Parse.setApplicationId("aIoqyo8zQ1MXzFauAMYcbjWudyqN2wqCNYzv1U50", clientKey: "U5JhxyI72Gtz2QfuIrzb3U33Sj8MKaR3v8ZNjrwk")
        PFFacebookUtils.initializeFacebook()
        
        //  NSUserDefaults
        
        if let isFirstTime = defaults.stringForKey("firstTimeBool")
        {
            println("The key exist")
        }
        else {
            //If the key don't exist, we create it
            defaults.setBool(true, forKey: "firstTimeBool")
            defaults.synchronize()
        }
        
        
        
        //Track App Open
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        if (application.applicationIconBadgeNumber != 0) {
            application.applicationIconBadgeNumber = 0;
            PFInstallation.currentInstallation().saveInBackgroundWithBlock(nil )
        }
        
        var types: UIUserNotificationType = UIUserNotificationType.Badge |
            UIUserNotificationType.Alert |
            UIUserNotificationType.Sound
        
        var settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: types, categories: nil )
        application.registerUserNotificationSettings( settings )
        application.registerForRemoteNotifications()
        
        var navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.blackColor()
        navigationBarAppearace.barTintColor = UIColor.blackColor()
        navigationBarAppearace.barStyle = UIBarStyle.BlackTranslucent
        
        
        
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.addUniqueObject("5Th Ave", forKey: "channels")
        currentInstallation.saveInBackgroundWithBlock(nil)
        
        // Enable public read access by default, with any newly created PFObjects belonging to the current user
        let defaultACL:PFACL = PFACL()
        defaultACL.setPublicWriteAccess(true)
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        
        //  Login tranistion
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var currentUser = PFUser.currentUser()
        println(currentUser?.username)
        
        if currentUser != nil {
            home = storyboard.instantiateViewControllerWithIdentifier("mainContainer") as! ContainerViewController
            self.window?.rootViewController = home
        }
        else {
            welcome = storyboard.instantiateViewControllerWithIdentifier("welcome") as! FifthWelcomeVC
            self.window?.rootViewController = welcome
            
        }
        
        
        //  set root viewController based on whether pfuser current  is logged in
        //  do this here
       // self.window?.rootViewController = welcome
        
        
        self.window?.makeKeyAndVisible()

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
        
        // Clear badge and update installation, required for auto-incrementing badges.
        if (application.applicationIconBadgeNumber != 0) {
            application.applicationIconBadgeNumber = 0;
            PFInstallation.currentInstallation().saveInBackgroundWithBlock(nil)
        }
        
        // Clears out all notifications from Notification Center.
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        
        application.applicationIconBadgeNumber = 1;
        application.applicationIconBadgeNumber = 0;
        
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
        FBAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }
    
    //MARK: Facebook
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        
        return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication, withSession: PFFacebookUtils.session())
        
        
       // var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        
       // return wasHandled
        
        // older code using sessions, will look into it
        //            if ((PFFacebookUtils.session()) != nil){
        //                               return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication, withSession: PFFacebookUtils.session())
        //            }
        //            else {
        //                return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        //
        //            }
    }
    
    //MARK:  Push
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock(nil)
        
        
        // <>と" "(空白)を取る
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        println( deviceTokenString )
        
    }
    
    func application( application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError ) {
        println( error.localizedDescription )
        if (error.code != 3010) { // 3010 is for the iPhone Simulator
            println("Application failed to register for push notifications:" ,error)
        }
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        NSNotificationCenter.defaultCenter().postNotificationName("5ThAveRemoteNotification", object: nil, userInfo: userInfo)
        if UIApplication.sharedApplication().applicationState != UIApplicationState.Active{
            // Track app opens due to a push notification being acknowledged while the app wasn't active.
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayloadInBackground(userInfo, block: nil)
        }
        
        //        if ([PFUser currentUser]) {
        //            if ([self.tabBarController viewControllers].count > PAPActivityTabBarItemIndex) {
        //                UITabBarItem *tabBarItem = [[self.tabBarController.viewControllers objectAtIndex:PAPActivityTabBarItemIndex] tabBarItem];
        //
        //                NSString *currentBadgeValue = tabBarItem.badgeValue;
        //
        //                if (currentBadgeValue && currentBadgeValue.length > 0) {
        //                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        //                    NSNumber *badgeValue = [numberFormatter numberFromString:currentBadgeValue];
        //                    NSNumber *newBadgeValue = [NSNumber numberWithInt:[badgeValue intValue] + 1];
        //                    tabBarItem.badgeValue = [numberFormatter stringFromNumber:newBadgeValue];
        //                } else {
        //                    tabBarItem.badgeValue = @"1";
        //                }
        //            }
        //        }
        
        if (PFUser.currentUser() != nil){
            
        }
    }

    
    //MARK:  Core Data Stack
    
     lazy var applicationDocumentsDirectory: NSURL = {
        
        //  the directory the application uses to store the core data store file. 
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    } ()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = NSBundle.mainBundle().URLForResource("FifthAveCoreDataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    } ()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        var persistentCoordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("FifthAve.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the applications saved data"
        
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        if persistentCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: mOptions, error: &error) == nil {
            persistentCoordinator == nil
            
            //  report any error 
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the applications saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "Error! Strange things happened", code: 9999, userInfo: dict)
            
            println("unresolved error \(error), \(error!.userInfo)")
            
            // abort() causes the app to generate a crash log and terminate .  dont use this in app store version, only for dev if neccessary
            // abort()
            
        }
        
        return persistentCoordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        
        let persistentCoordinator = self.persistentStoreCoordinator
        
        if persistentCoordinator == nil {
            
            return nil
        }
        
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = persistentCoordinator
        
        return managedObjectContext
        
    } ()
    
    //   Saving Support
    
    func saveContext () {
        
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            
            if moc.hasChanges && !moc.save(&error) {
                //  replace this with code to handle error
                println("unresolved error here \(error!.userInfo)")
            }
        }
    }
    

}












































