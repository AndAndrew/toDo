//
//  ToDoCell.swift
//  toDoList
//
//  Created by Andrey Krivokhizhin on 19.03.2022.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var toDoLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        doneButton.imageView?.image == UIImage(systemName: "circle") ? doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal) : doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
}
