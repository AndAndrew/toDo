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
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var toDo = Base.ToDoItem(title: "", category: "", comment: "", deadline: Date.now)
    var index = 0
    var saveCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        titleTextField.text = toDo.title
        commentTextView.text = toDo.comment
        let categoryIndex = Base.shared.categories.firstIndex(of: toDo.category)
        categoryPicker.selectRow(categoryIndex ?? 0, inComponent: 0, animated: false)
        saveButton.layer.cornerRadius = 7
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let detailToDo = Base.ToDoItem(title: titleTextField.text!,
                                       category: Base.shared.categories[categoryPicker.selectedRow(inComponent: 0)],
                                       comment: commentTextView.text,
                                       deadline: Date.now)
        if detailToDo != toDo {
            Base.shared.deleteToDoItems(itemIndex: index)
            Base.shared.toDoItems.insert(detailToDo, at: index)
        }
        dismiss(animated: true, completion: saveCompletion)
    }
}

extension DetailViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Base.shared.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Base.shared.categories[row]
    }
}
