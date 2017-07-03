//
//  AppDelegate.swift
//  RecipeViewer
//
//  Created by Yves Yang on 08/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController: UIViewController
        if let user = UserSession.sharedInstance.userSession {
            let profileViewController = ProfileViewController1()
            profileViewController.user = user
            let profileNavigationController = UINavigationController(rootViewController: profileViewController)
            let profileInfosViewController = ProfileInfosWithImageViewController()
            let categoriesTableViewController = UINavigationController(rootViewController:CategoriesTableViewController(style: .plain))
            let tabBarController = UITabBarController()
            profileInfosViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_profile"), selectedImage: UIImage(named: "ic_profile")?.maskWithColor(color: UIColor.blue))
            profileNavigationController.tabBarItem = UITabBarItem(title: "My recipes", image: UIImage(named: "ic_my_recipe"), selectedImage: UIImage(named: "ic_my_recipe")?.maskWithColor(color: UIColor.blue))
            categoriesTableViewController.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(named: "ic_recipe"), selectedImage: UIImage(named: "ic_recipe")?.maskWithColor(color: UIColor.blue))

            tabBarController.viewControllers = [profileNavigationController,categoriesTableViewController, profileInfosViewController]
            tabBarController.tabBar.isTranslucent = false
            rootViewController = tabBarController
            
        } else {
            rootViewController = LoginViewController()
            //let sharedInstance = FBSDKApplicationDelegate.sharedInstance()
            //sharedInstance?.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

