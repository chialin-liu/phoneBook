//
//  ViewController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit
import CoreData
class ConnectionsViewController: UITableViewController {
    let cellId = "cellId"
    var connections = [Connection]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        connections = CoreDataManager.shared.fetchConnections()
        tableView.reloadData()
        //test
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(addConnection))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        //end
        view.backgroundColor = .white
        navigationItem.title = "PhoneBook"
        tableView.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 60/255, alpha: 1)
        tableView.register(ConnectionCell.self, forCellReuseIdentifier: cellId)
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        //purpose: to set a blank view at the cellview bottom
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Plus", style: .plain, target: self, action: #selector(handlePlus))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    @objc func handleReset() {
        CoreDataManager.shared.removeAllBatch()
        //animation way
        var deleteIndices = [IndexPath]()
        for (index, _) in connections.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            deleteIndices.append(indexPath)
        }
        connections.removeAll()
        tableView.deleteRows(at: deleteIndices, with: .fade)
        
        //easy way
//        connections.removeAll()
//        tableView.reloadData()
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
}

