//
//  ViewController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit
import CoreData
class ConnectionsViewController: UITableViewController, CreateConnectionControllerDelegate {
    func didUpdateConnection() {
        tableView.reloadData()
    }
    func didAddConnection(connection: Connection) {
        connections.insert(connection, at: 0)
        //method1 -> reload All data
//        tableView.reloadData()
        //method2 -> insert row in tableView
        let index = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedIndex = indexPath.row
        let connection = connections[selectedIndex]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completeHandler) in
            self.connections.remove(at: selectedIndex)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(connection)
            try? context.save()
            completeHandler(false)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completeHandler) in
            let createConnectionController = CreateConnectionController()
            createConnectionController.delegate = self
            createConnectionController.connection = self.connections[selectedIndex]
            let navController = UINavigationController(rootViewController: createConnectionController)
            self.present(navController, animated: true, completion: nil)
            completeHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    func fetchConnections() {
        //initialization Core data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Connection>(entityName: "Connection")
        let fetches = try? context.fetch(fetchRequest)
        guard let fetcheConnections = fetches else { return }
        connections = fetcheConnections
        //TBD
        tableView.reloadData()
    }
    let cellId = "cellId"
    var connections = [Connection]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchConnections()
        //test
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(addConnection))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        //end
        view.backgroundColor = .white
        navigationItem.title = "PhoneBook"
        tableView.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 60/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        //purpose: to set a blank view at the cellview bottom
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Plus", style: .plain, target: self, action: #selector(handlePlus))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    @objc func handlePlus() {
        let createConnectionController = CreateConnectionController()
//        createConnectionController.connectionVC = self
        createConnectionController.delegate = self
        let navController = CustomNavigationController(rootViewController: createConnectionController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true) {
            print("Completed")
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .systemTeal
        cell.textLabel?.text = connections[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createConnectionController = CreateConnectionController()
        createConnectionController.delegate = self
        createConnectionController.connection = self.connections[indexPath.row]
        let navController = UINavigationController(rootViewController: createConnectionController)
        self.present(navController, animated: true, completion: nil)
    }
}

