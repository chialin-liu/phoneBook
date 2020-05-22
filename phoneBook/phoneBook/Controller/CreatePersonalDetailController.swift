//
//  CreatePersonalDetailController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/23.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
class CreatePersonalDetailController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        navigationItem.title = "Create Detail Info"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancle))
    }
    @objc func handleCancle() {
        dismiss(animated: true, completion: nil)
    }
}
