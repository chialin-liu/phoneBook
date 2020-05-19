//
//  CreateConnectionController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
class CreateConnectionController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationItem.title = "Create information"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    @objc func handleCancel() {
        dismiss(animated: true) {
            print("Back to connectionVC")
        }
    }

}
