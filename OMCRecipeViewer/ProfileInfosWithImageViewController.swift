//
//  ProfileInfosWithImageViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

protocol ProfileInfosViewControllerDelegate: class {
    func didPushEdit()
    func didPushLogOut()
}

class ProfileInfosWithImageViewController: UIViewController {

    var user = UserSession.sharedInstance.userSession {
        didSet {
            profileInfosView.setNeedsDisplay()
            formViewController.user = user
        }
    }
    
    var profileInfosView: ProfileInfosView1
    var formViewController: ProfileInfosViewController

    init() {
        profileInfosView = ProfileInfosView1.instantiate()
        formViewController = ProfileInfosViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViews), name: NSNotification.Name(rawValue: "userChanged"), object: nil)
        profileInfosView.delegate = self
        formViewController.user = user
        guard let tableView = formViewController.view else { return }
        self.view.addSubview(profileInfosView)
        profileInfosView.autoPinEdge(toSuperviewEdge: .leading)
        profileInfosView.autoPinEdge(toSuperviewEdge: .trailing)
        profileInfosView.autoPinEdge(toSuperviewEdge: .top)
        profileInfosView.autoSetDimension(.height, toSize: 115)
        self.view.addSubview(tableView)
        tableView.autoPinEdge(.top, to: .bottom, of: profileInfosView)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        user = UserSession.sharedInstance.userSession
    }
    
    @objc func reloadViews() {
        self.user = UserSession.sharedInstance.userSession
    }
}

extension ProfileInfosWithImageViewController: ProfileInfosViewControllerDelegate {
    func didPushEdit() {
        let vc = EditProfileViewController()
        vc.user = user
        present(vc, animated: true, completion: nil)
    }   
    
    func didPushLogOut() {
        UserSession.logOut()
        let loginVC = LoginViewController()
        present(loginVC, animated: true, completion: nil)
        self.dismissVC()
    }
}
