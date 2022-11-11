//
//  ViewController.swift
//  PackList
//
//  Created by Louis-Michel Lebrun on 10.11.22.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var willIchHin = ["Kingston","Honolulu","Las Vegas","Tibet","Tijuana"]
    var daWarIchSchon: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
    }
    
    @IBAction func startEditing(_ sender: Any) {
        myTableView.allowsMultipleSelectionDuringEditing = true
        myTableView.isEditing = !myTableView.isEditing
    }
   
    @IBAction func deleteRows(_ sender: Any) {
        if let selectedRows = myTableView.indexPathsForSelectedRows {
            var items = [String]()
            for indexPath in selectedRows  {
                items.append(willIchHin[indexPath.row])
            }
            for item in items {
                if let index = willIchHin.firstIndex(of: item) {
                    willIchHin.remove(at: index)
                }
            }
            myTableView.beginUpdates()
            myTableView.deleteRows(at: selectedRows, with: .automatic)
            myTableView.endUpdates()
        }
    }
    
    
    @IBAction func hinzufügen() {
        let alert = UIAlertController(title: "Hinzufügen", message: "Wohin genau?", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel))
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default, handler: {(_) in
            let text = alert.textFields?.first?.text
            self.willIchHin.append(text!)
            self.myTableView.reloadData()
            
            
        }))
        
        present(alert, animated: true)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView)-> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return willIchHin.count
        } else {
            return daWarIchSchon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "zuBesuchen", for: indexPath)
        
    
        
        if indexPath.section == 0{
            var content = cell.defaultContentConfiguration()
            content.text = willIchHin[indexPath.row]
            cell.contentConfiguration = content
            cell.accessoryType = .none
            
        }else{
            if indexPath.section == 1{
                var content = cell.defaultContentConfiguration()
                content.text = daWarIchSchon[indexPath.row]
                cell.contentConfiguration = content
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Möchte ich hin"
        } else {
            return "Da war ich"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            if indexPath.section == 0{
                willIchHin.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }else{
                daWarIchSchon.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (myTableView.isEditing == false){
            if indexPath.section == 0{
                let data = willIchHin[indexPath.row]
                daWarIchSchon.append(data)
                willIchHin.remove(at: indexPath.row)
            }else if indexPath.section == 1{
                let data = daWarIchSchon[indexPath.row]
                willIchHin.append(data)
                daWarIchSchon.remove(at: indexPath.row)
            }
            myTableView.reloadData()
        }
    }
}




