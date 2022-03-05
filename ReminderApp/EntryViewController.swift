//
//  EntryViewController.swift
//  EntryViewController
//
//  Created by Nilesh Kumar on 03/01/22.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleTextFiled: UITextField!
    @IBOutlet var subtitleTextFiled: UITextField!

    @IBOutlet weak var datePickOutlet: UIDatePicker!
    
    public var completion: ((String, String, Date) -> Void)?
    
    var dateFiled: Date!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Reminder"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savedata))
    }
    
    @objc func savedata(){
        
        if let titleText = titleTextFiled.text, !titleText.isEmpty,
           let subTitleText = subtitleTextFiled.text, !subTitleText.isEmpty {
            let datepic = datePickOutlet.date
            completion?(titleText, subTitleText, datepic)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
