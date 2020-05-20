//
//  ViewController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class ConnectionsViewController: UITableViewController, CreateConnectionControllerDelegate {
    func didAddConnection(connection: Connection) {
        connections.insert(connection, at: 0)
        //method1 -> reload All data
//        tableView.reloadData()
        //method2 -> insert row in tableView
        let index = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    let cellId = "cellId"
    var connections = [
        Connection(name: "yorick", phoneNumber: 12345678),
        Connection(name: "Mars", phoneNumber: 87654321)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}

