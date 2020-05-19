//
//  ViewController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Plus", style: .plain, target: self, action: #selector(handlePlus))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    @objc func handlePlus() {
        print("PLUS")
    }
    func setupNavigationBar() {
        //        UIViewController().configureNavigationBar(largeTitleColor: .blue, backgoundColor: .yellow, tintColor: .red, title: "PhoneBook", preferredLargeTitle: true)
                navigationController?.navigationBar.barTintColor = .black
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationController?.navigationBar.isTranslucent = false
                //Be aware
                //instead of using navigationController?.navigationItem.title
                navigationItem.title = "PhoneBook"
                navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

