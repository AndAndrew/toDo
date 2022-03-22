//
//  DetailViewController.swift
//  toDoList
//
//  Created by Andrey Krivokhizhin on 22.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        categories = ["home", "work", "health", "pets"]
        saveButton.layer.cornerRadius = 7
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        print("save")
        dismiss(animated: true)
    }
}

extension DetailViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row]
    }
}
