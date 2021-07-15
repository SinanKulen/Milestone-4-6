//
//  TableViewController.swift
//  Milestone 4-6
//
//  Created by Sinan Kulen on 15.07.2021.
//

import UIKit
class TableViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(deleteItem))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItem))
        
        navigationItem.rightBarButtonItems = [shareButton, addButton]
        
        shoppingList += ["Test"]
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return shoppingList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    
    @objc func addItem(){
        let ac = UIAlertController(title: "Please writing to Shopping List", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let supply = ac.textFields?[0].text else { return }
            self.submit(supply)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    
    }
    
    func submit(_ item: String) {
        if !item.isEmpty {
            shoppingList.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
   }
    
    @objc func deleteItem(){
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareItem(){
        let text = "List to buy:"
        let list = shoppingList.joined(separator: "\n")
        let ac = UIActivityViewController(activityItems: [text, list], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        present(ac, animated: true)
    }
}

