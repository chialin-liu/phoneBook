//
//  ConnectionsController+UITableView.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/22.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
extension ConnectionsViewController {
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
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if connections.count == 0 {
            let label = UILabel()
            label.text = "No connections"
            label.textColor = .white
            label.textAlignment = .center
            return label
        } else {
            return UIView()
        }
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if connections.count == 0 {
            return 150
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ConnectionCell else { return UITableViewCell() }
        cell.connection = connections[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personalDetailController = PersonalDetailController()
        personalDetailController.connection = connections[indexPath.row]
        navigationController?.pushViewController(personalDetailController, animated: true)
    }
}
