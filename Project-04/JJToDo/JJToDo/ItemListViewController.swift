//
//  ItemListViewController.swift
//  JJToDo
//
//  Created by admin on 2019/8/16.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dataProvider: ItemListDataProvider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = dataProvider
        tableView.dataSource = dataProvider
        
        dataProvider.itemManager = ToDoItemManager()
        NotificationCenter.default.addObserver(self, selector: #selector(showDetial(_:)), name: Notification.ItemSelectedNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func showDetial(_ sender: Notification) {
        guard let index = sender.userInfo?["index"] as? Int else { fatalError() }
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailViewControllerIdentifier) as? DetialsViewController,
        let itemManger = dataProvider.itemManager {
            guard index < itemManger.toDoCount else {
                return
            }
            nextViewController.item = itemManger.itme(at: index)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        guard let inputViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController else { return }
        
        inputViewController.itemManger = dataProvider.itemManager
        present(inputViewController, animated: true, completion: nil)
    }
}

