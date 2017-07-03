//
//  ProfileView.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class ProfileView1: UIView, NibLoadableView {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var numberOfRecipes: UILabel!
    @IBOutlet weak var numberOfFollowers: UILabel!
    @IBOutlet weak var numberOfFollowing: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var Follow: UIButton!
    
    var user: User?
    
    static func instantiate() -> ProfileView1 {
        let nib = UINib(nibName: self.NibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! ProfileView1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Follow.setTitle("Follow", for: .normal)
        Follow.setTitle("Following", for: .selected)
    }
    
    public func setFollowersAndFollowing() {
        let userID = UserSession.sharedInstance.userSession?.id
        guard let pageUserID = user?.id else { return }
        DispatchQueue.global(qos: .userInteractive).async {
            // Bounce back to the main thread to update the UI
                FollowersRequest.init(userID: pageUserID).perform { users in
                    DispatchQueue.main.async {
                        self.Follow.isSelected = !users.filter({ $0.id == userID }).isEmpty
                        self.numberOfFollowers.text = "\(users.count)"
                    }
                }
                FollowingRequest.init(userID: pageUserID).perform { users in
                    DispatchQueue.main.async {
                        self.numberOfFollowing.text = "\(users.count)"
                    }

                }
        }
        if (pageUserID == userID) {
            Follow.isHidden = true
        } else {
            Follow.isHidden = false
        }
    }
    
    @IBAction func didTapFollow() {
        let selected = Follow.isSelected
        guard let userID = UserSession.sharedInstance.userSession?.id,
                let followerID = user?.id else { return }
        if selected {
            UnFollowRequest(followerID: followerID, userID: userID).perform {
                self.Follow.isSelected = false
                self.setFollowersAndFollowing()
            }
        } else {
            FollowRequest(followerID: followerID, userID: userID).perform {_ in 
                self.Follow.isSelected = true
                self.setFollowersAndFollowing()
            }
        }
    }
    
    public func setNumberOfRecipes(number: Int) {
        numberOfRecipes.text = "\(number)"
    }
    
    public func setInfos(user: User?) {
        if let user = user {
            fullname.text = "\(user.firstname) \(user.lastname)"
        }
    }
}
