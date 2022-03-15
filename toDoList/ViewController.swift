//
//  ViewController.swift
//  toDoList
//
//  Created by Andrey Krivokhizhin on 10.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var toDo: [String] = (UserDefaults.standard.object(forKey: "toDoArray") as? [String] != nil)
    ? UserDefaults.standard.object(forKey: "toDoArray") as! [String]
    : []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonDidTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add what to do.", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            guard var toDoText = alertController.textFields![0].text else { return }
            toDoText = toDoText.trimmingCharacters(in: .whitespaces)
            if toDoText != "" {
                self.toDo.insert(toDoText, at: 0)
                DispatchQueue.main.async {
                    UserDefaults.standard.set(self.toDo, forKey: "toDoArray")
                }
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.view.tintColor = .darkGray
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = toDo[indexPath.row]
        return cell
    }
}
