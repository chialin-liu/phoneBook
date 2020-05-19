//
//  ViewController.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/19.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 60/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        //purpose: to set a blank view at the cellview bottom
        tableView.tableFooterView = UIView()
        setupNavigationBar()
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
}

