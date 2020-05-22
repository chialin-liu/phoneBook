//
//  PersonalDetailController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/22.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
class PersonalDetailController: UITableViewController {
    var connection: Connection? {
        //TBD
        didSet { //what's difference between viewWillAppear and didSet?
            navigationItem.title = connection?.name
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
    }
    @objc func handleAdd() {
        let createPersonalDetailController = CreatePersonalDetailController()
        let navController = UINavigationController(rootViewController: createPersonalDetailController)
        present(navController, animated: true, completion: nil)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationItem.title = connection?.name
//    }
}
