//
//  SignUpFormViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit
import Eureka

class SignUpFormViewController: FormViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        EmailRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        PasswordRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        IntRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        form +++ Section("Informations")
            <<< TextRow() { row in
                row.title = "firstname"
                row.tag = "firstname"
                row.add(rule: RuleMaxLength(maxLength: 20))
                row.add(rule: RuleRequired(msg: "required"))
                row.validationOptions = .validatesOnChange
            }
            <<< TextRow() { row in
                row.title = "lastname"
                row.tag = "name"
                row.add(rule: RuleMaxLength(maxLength: 20))
                row.add(rule: RuleRequired(msg: "required"))
                row.validationOptions = .validatesOnChange
            }
            <<< EmailRow() { row in
                row.title = "email"
                row.tag = "email"
                row.add(rule: RuleRequired(msg: "required"))
                row.add(rule: RuleEmail(msg: "this must meet email format"))
                row.validationOptions = .validatesOnChange
            }
            <<< PasswordRow() { row in
                row.title = "Password"
                row.tag = "password"
                row.add(rule: RuleMinLength(minLength: 5))
                row.add(rule: RuleMaxLength(maxLength: 10))
                row.add(rule: RuleRequired(msg: "required"))
            }
            
            <<< PasswordRow() { row in
                row.title = "Confirm Password"
                row.add(rule: RuleClosure { value in
                    if let password = self.form.rowBy(tag: "password") as? PasswordRow,
                        password.value == value {
                        return nil
                    }
                    return ValidationError(msg: "password must be the same")
                })
                row.validationOptions = .validatesOnBlur
                row.add(rule: RuleRequired(msg: "required"))
            }

            <<< PickerRow<String>() { row in
                row.title = "country"
                row.tag = "country"
                var countries: [String] = []
                for code in NSLocale.isoCountryCodes as [String] {
                    let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                    let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                    countries.append(name)
                }
                row.options = countries
                row.value = user?.country
            }
            
            <<< IntRow() { row in
                row.title = "age"
                row.tag = "age"
                if let user = user {
                    row.placeholder = user.age
                }
                row.add(rule: RuleSmallerThan(max: 120))
                row.add(rule: RuleRequired(msg: "required"))
            }
            <<< SegmentedRow<String>() { row in
                row.title = "sexe"
                row.tag = "sexe"
                row.options = ["male", "female"]
            }
            <<< ButtonRow() { row in
                row.title = "done"
                }.onCellSelection { cell, row in
                    self.validate()
        }
        // Do any additional setup after loading the view.
    }
    
    func validate() {
        if form.validate().isEmpty {
            let values = form.values() as JSON
            SignUpRequest(values: values).perform {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
