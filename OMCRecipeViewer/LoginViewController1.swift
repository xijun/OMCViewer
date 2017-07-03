//
//  ViewController.swift
//  RecipeViewer
//
//  Created by Yves Yang on 08/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit
import PureLayout

protocol LoginViewControllerDelegate: class {
    func goToViewController(user: User)
    func goToSignUp()
}

class LoginViewController: UIViewController {

    var loginView: LoginView1
    
    init() {
        loginView = LoginView1.instantiate()
        super.init(nibName: nil, bundle: nil)
        loginView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
        loginView.autoPinEdgesToSuperviewEdges()
        loginView.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginViewController: LoginViewControllerDelegate {
    
    func goToViewController(user: User) {
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
        present(tabBarController, animated: true, completion: nil)
    }
    
    func goToSignUp() {
        let signUpVC = SignUpFormViewController()
        present(signUpVC, animated: true, completion: nil)
    }
}

