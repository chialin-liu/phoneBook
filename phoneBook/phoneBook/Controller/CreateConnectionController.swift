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
    var nameLabel: UILabel = UILabel()
    var phoneLabel: UILabel = UILabel()
    var nameTextField: UITextField = UITextField()
    var phoneTextField: UITextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 60/255, alpha: 1)
        navigationItem.title = "Create information"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
   @objc func handleSave() {
        print("Save")
    let connection = Connection(name: nameTextField.text ?? "", phoneNumber: Int(phoneTextField.text ?? "0") ?? 0)
    }
    func setupUI() {
        nameLabel = creatNameLabel()
        phoneLabel = createPhoneLabel()
        nameTextField = createNameTextField()
        phoneTextField = createPhoneTextField()
        let backgroundView = UIView()
        
        view.addSubview(backgroundView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        
        backgroundView.backgroundColor = .lightGray
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //view.topAnchor will hide the label, instead, use safeAreaLayoutGuide to place correct position
//        nameLabel.topAnchor.constraint(equalTo: view.topAnchor)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        nameLabel.backgroundColor = .red
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
//        nameTextField.backgroundColor = .blue
//        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        phoneTextField.bottomAnchor.constraint(equalTo: phoneLabel.bottomAnchor).isActive = true
        
    }
    func creatNameLabel() -> UILabel {
        let label = UILabel()
        label.text = "Name"
//        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
        func createPhoneLabel() -> UILabel {
            let label = UILabel()
            label.text = "Phone"
    //        label.backgroundColor = .lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
    func createNameTextField() -> UITextField {
        let txfield = UITextField()
        txfield.placeholder = "Enter Name"
        txfield.translatesAutoresizingMaskIntoConstraints = false
        return txfield
    }
    func createPhoneTextField() -> UITextField {
        let txfield = UITextField()
        txfield.placeholder = "Enter Phone"
        txfield.translatesAutoresizingMaskIntoConstraints = false
        return txfield
    }
    @objc func handleCancel() {
        dismiss(animated: true) {
            print("Back to connectionVC")
        }
    }

}
