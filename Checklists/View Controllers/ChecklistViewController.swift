//
//  ViewController.swift
//  Checklists
//
//  Created by Chakra Jumpajeen on 9/2/21.
//

import UIKit

//class ViewController: UIViewController {
//class ChecklistViewController: UITableViewController {
class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    //var items = [ChecklistItem]()
    var checklist: Checklist!
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
      navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        navigationController?.popViewController(animated: true)
    }
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.firstIndex(of: item) {
          let indexPath = IndexPath(row: index, section: 0)
          if let cell = tableView.cellForRow(at: indexPath) {
            configureText(for: cell, with: item)
          }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        title = checklist.name
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = checklist.items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt    indexPath: IndexPath){
        // 1
        checklist.items.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem){
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    func configureText(for cell: UITableViewCell,with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        //label.text = "\(item.itemID): \(item.text)"
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?){
        // 1
        if segue.identifier == "AddItem" {
            // 2
            let controller = segue.destination as!ItemDetailViewController
            // 3
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as!ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    func addItemViewController(_ controller: ItemDetailViewController,
                               didFinishEditing item: ChecklistItem){
        if let index = checklist.items.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at:indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}

//===========================================
//        DELETE FUNCTION
//===========================================
/*
func documentsDirectory() -> URL {let paths = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)
    return paths[0]
}
func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
}
func saveChecklistItems() {
  let encoder = PropertyListEncoder()
  do {
    let data = try encoder.encode(checklist.items)
    try data.write(
      to: dataFilePath(),
      options: Data.WritingOptions.atomic)
  } catch {
    print("Error encoding item array: \(error.localizedDescription)")
  }
}
func loadChecklistItems() {
    // 1
    let path = dataFilePath()
    // 2
    if let data = try? Data(contentsOf: path)
    {
        // 3
        let decoder = PropertyListDecoder()
        do {
            // 4
            checklist.items = try decoder.decode(
                [ChecklistItem].self,from: data)
        } catch {
            print("Error decoding item array: \(error.localizedDescription)")
        }
    }
}
*/
