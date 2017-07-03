//
//  InputCommentView.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class InputCommentView: UIView, NibLoadableView {

    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputText: UITextView!
    
    weak var delegate: CommentsViewControllerDelegate?

    static func instantiate() -> InputCommentView {
        let nib = UINib(nibName: self.NibName, bundle: nil)
        let recipeView = nib.instantiate(withOwner: self, options: nil).first as! InputCommentView
        return recipeView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputText.layer.borderWidth = 2.0
        inputText.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func didTapSendButton() {
        guard let text = inputText.text, !text.isEmpty else { return }
        inputText.text = ""
        delegate?.didTapSendButton(text: text)
    }
}
