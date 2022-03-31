//
//  ViewController.swift
//  toDoList
//
//  Created by Andrey Krivokhizhin on 10.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categoryColors: [UIColor] = [.clear, .cyan, .green, .blue, .orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add what to do.", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "title"
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "comment"
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            guard var title = alertController.textFields![0].text,
                  let comment = alertController.textFields![1].text else { return }
            title = title.trimmingCharacters(in: .whitespaces)
            if title != "" {
                Base.shared.saveToDoItems(title: title, category: "", comment: comment, deadline: Date.now)
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
        Base.shared.toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoCell
        cell.backgroundColor = .clear
        cell.toDoLabel.text = Base.shared.toDoItems[indexPath.row].title
        cell.categoryLabel.text = Base.shared.toDoItems[indexPath.row].category
        cell.categoryLabel.textColor = categoryColors[Base.shared.categories.firstIndex(of: Base.shared.toDoItems[indexPath.row].category) ?? 0]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            Base.shared.deleteToDoItems(itemIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.toDo = Base.shared.toDoItems[indexPath.row]
        detailVC.index = indexPath.row
        detailVC.saveCompletion = {
            tableView.reloadData()
        }
        present(detailVC, animated: true, completion: nil)
    }
}
