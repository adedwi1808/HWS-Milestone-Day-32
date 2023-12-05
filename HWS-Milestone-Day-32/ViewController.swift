//
//  ViewController.swift
//  HWS-Milestone-Day-32
//
//  Created by Ade Dwi Prayitno on 05/12/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Milestone - 32"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(resetShoppingList))
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(showInputPopup))
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share))
        navigationItem.rightBarButtonItems = [addButton, share]
    }

    @objc func showInputPopup() {
        let ac = UIAlertController(title: "Add Item", message: "Please Type Item Name", preferredStyle: .alert)
        
        ac.addTextField()
        
        let action = UIAlertAction(title: "Add", style: .default ) { [weak self, weak ac] _ in
            guard let self,
                  let ac else { return }
            guard let text = ac.textFields?.first?.text else { return }
                    
            self.insert(itemName: text)
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func share() {
        let shoppingListTextJoined = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [shoppingListTextJoined], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        present(vc, animated: true)
    }
    
    
    func insert(itemName: String) {
        shoppingList.insert(itemName, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func resetShoppingList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
}

