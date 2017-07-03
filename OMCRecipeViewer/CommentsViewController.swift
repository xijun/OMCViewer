//
//  CommentsViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

protocol CommentsViewControllerDelegate: class {
    func didTapSendButton(text: String)
}

class CommentsViewController: UIViewController {
    
    var tableViewController: CommentsTableViewController
    var inputCommentView: InputCommentView
    
    init(recipe: Recipe, comments: [Comment]) {
        tableViewController = CommentsTableViewController(style: .plain)
        tableViewController.recipe = recipe
        tableViewController.comments = comments
        inputCommentView = .instantiate()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputCommentView.delegate = self
        self.view.addSubview(inputCommentView)
        inputCommentView.autoPinEdge(toSuperviewEdge: .leading)
        inputCommentView.autoPinEdge(toSuperviewEdge: .trailing)
        inputCommentView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
        inputCommentView.autoSetDimension(.height, toSize: 80)
        guard let tableView = tableViewController.view else { return }
        self.view.addSubview(tableView)
        tableView.autoPinEdge(.bottom, to: .top, of: inputCommentView)
        tableView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
    }
}

extension CommentsViewController: CommentsViewControllerDelegate {
    func didTapSendButton(text: String) {
        tableViewController.sendComment(text: text)
    }
}
