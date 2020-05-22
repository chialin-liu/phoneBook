//
//  ConnectionController+CreateConnection.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/22.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
extension ConnectionsViewController: CreateConnectionControllerDelegate {
        func didUpdateConnection() {
            tableView.reloadData()
        }
        func didAddConnection(connection: Connection) {
            connections.append(connection)
            //method1 -> reload All data
    //        tableView.reloadData()
            //method2 -> insert row in tableView
            let index = IndexPath(row: connections.count - 1, section: 0)
            tableView.insertRows(at: [index], with: .automatic)
        }
}
