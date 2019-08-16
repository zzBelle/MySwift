//
//  InputViewController.swift
//  JJToDo
//
//  Created by admin on 2019/8/13.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    var itemManger: ToDoItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        locationTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func saveBtn() {
        guard let titleString = titleTextField.text, titleString.count > 0 else {
            return
        }
        var date: Date?
        if datePicker != nil {
            date = datePicker.date
        }
        var descriptionSting: String?
        if descriptionTextField != nil {
            descriptionSting = descriptionTextField.text
        }
        
        var placeMark:CLPlacemark?
        var locationName: String?
        
        if locationTextField != nil {
            locationName = locationTextField.text
            if let locationName = locationName, locationName.count > 0 {
                geocoder.geocodeAddressString(locationName) {
                    [weak self] placeMarks, _ in placeMark = placeMarks?.first
                    let itme = ToDoItem(title: titleString,
                                        itemDescription: descriptionSting,
                                        timeStamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
                    DispatchQueue.main.async {
                        self?.itemManger?.add(itme)
                        self?.dismiss(animated: true)
                    }
                }
            } else {
                let item = ToDoItem(title: titleString,
                                    itemDescription: descriptionSting,
                                    timeStamp: date?.timeIntervalSince1970,
                                    location: nil)
                
                self.itemManger?.add(item)
                dismiss(animated: true)
            }
        } else {
            let item = ToDoItem(title: titleString,
                                itemDescription: descriptionSting,
                                timeStamp: date?.timeIntervalSince1970)
            self.itemManger?.add(item)
            dismiss(animated: true)
        }
    
}
    
    @IBAction func cancelBtn() {

        dismiss(animated: true, completion: nil)
    }
}

extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        view.endEditing(true)
        return false
    }
}
