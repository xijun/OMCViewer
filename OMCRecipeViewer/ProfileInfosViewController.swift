//
//  ProfileInfosViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit
import Eureka
class ProfileInfosViewController: FormViewController {
    var user: User? = nil {
        didSet {
            guard let user = self.user else { return }
            form.setValues(["firstname": user.firstname, "lastname": user.lastname,
                            "email": user.email, "country": user.country, "age": user.age,
                            "sexe": user.sexe])
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = self.user else { return }
        
        form +++ Section("informations")
            <<< LabelRow() { row in
                row.title = "firstname"
                row.tag = "firstname"
                row.value = user.firstname
            }
            <<< LabelRow() { row in
                row.title = "lastname"
                row.tag = "lastname"
                row.value = user.lastname
            }
            <<< LabelRow() { row in
                row.title = "email"
                row.tag = "email"
                row.value = user.email
            }
            <<< LabelRow() { row in
                row.title = "country"
                row.tag = "country"
                row.value = user.country
            }
            <<< LabelRow() { row in
                row.title = "age"
                row.tag = "age"
                row.value = user.age
            }
            <<< LabelRow() { row in
                row.title = "sexe"
                row.tag = "sexe"
                row.value = user.sexe
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
