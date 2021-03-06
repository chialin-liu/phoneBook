//
//  CreateConnectionController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
protocol CreateConnectionControllerDelegate {
    func didAddConnection(connection: Connection)
    func didUpdateConnection()
}

class CreateConnectionController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var nameLabel: UILabel = UILabel()
    var phoneLabel: UILabel = UILabel()
//    var nameTextField: UITextField = UITextField()
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Phone"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    //TBD: why lazy var
    lazy var photoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "addPhoto"))
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.clipsToBounds = true
        iv.isHighlighted = true
//        iv.layer.cornerRadius = iv.frame.width / 2
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto)))
        return iv
    }()
    @objc func handleAddPhoto() {
        print("Add photo")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            photoImageView.image = editImage
        } else if let original = info[.originalImage] as? UIImage {
            photoImageView.image = original
        }
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
        photoImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    var delegate: CreateConnectionControllerDelegate?
    var connection: Connection? {
        didSet {
            nameTextField.text = connection?.name ?? ""
            phoneTextField.text = connection?.phone ?? ""
            datePicker.date = connection?.buildDate ?? Date()
            if let imageData = connection?.imageData{
                photoImageView.image = UIImage(data: imageData)
                photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
                photoImageView.clipsToBounds = true
            }
            
        }
    }
//    var connectionVC: ConnectionsViewController = ConnectionsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 60/255, alpha: 1)
//        navigationItem.title = "Create information"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if connection != nil {
            navigationItem.title = "Edit information"
        } else {
            navigationItem.title = "Create information"
        }
    }
    fileprivate func createConnection() {
        //initialization Core data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let connection = NSEntityDescription.insertNewObject(forEntityName: "Connection", into: context)
        connection.setValue(nameTextField.text, forKey: "name")
        connection.setValue(phoneTextField.text, forKey: "phone")
        connection.setValue(datePicker.date, forKey: "buildDate")
        let data = photoImageView.image?.jpegData(compressionQuality: 0.8)
        connection.setValue(data, forKey: "imageData")
        try? context.save()
        dismiss(animated: true) {
            self.delegate?.didAddConnection(connection: connection as! Connection)
        }
    }
    fileprivate func updateConnection() {
        //initialization Core data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        connection?.name = nameTextField.text
        connection?.phone = phoneTextField.text
        connection?.buildDate = datePicker.date
        let data = photoImageView.image?.jpegData(compressionQuality: 0.8)
        connection?.imageData = data
        try? context.save()
        dismiss(animated: true) {
            self.delegate?.didUpdateConnection()
        }
    }
    @objc func handleSave() {
        if connection == nil {
            createConnection()
        } else {
            updateConnection()
        }
    }
    func setupUI() {
        nameLabel = creatNameLabel()
        phoneLabel = createPhoneLabel()
        //cannot use didSet
//        nameTextField = createNameTextField()
//        phoneTextField = createPhoneTextField()
        let backgroundView = UIView()
        
        view.addSubview(backgroundView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(datePicker)
        view.addSubview(photoImageView)
        
        backgroundView.backgroundColor = .lightGray
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        photoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        //view.topAnchor will hide the label, instead, use safeAreaLayoutGuide to place correct position
//        nameLabel.topAnchor.constraint(equalTo: view.topAnchor)
//        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
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
        
        datePicker.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        
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
    @objc func handleCancel() {
        dismiss(animated: true) {
            print("Back to connectionVC")
        }
    }

}
