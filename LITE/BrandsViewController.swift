//
//  BrandsViewController.swift
//  LITE
//
//  Created by Kenichi Saito on 9/3/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import UIKit
import APIKit
import RealmSwift

class BrandsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BrandsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realm.objects(IGBrand.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandTableViewCell", for: indexPath) as! BrandTableViewCell
        let brand = self.realm.objects(IGBrand.self)[indexPath.row]
        cell.set(data: brand)
        return cell
    }
}

extension BrandsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = .zero
    }
}

extension BrandsViewController {
    fileprivate func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorInset = .zero
        let nib = UINib(nibName: "BrandTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BrandTableViewCell")
        
        self.navigationItem.title = "BRANDS"
        self.navigationController?.navigationBar.titleTextAttributes
            = [NSFontAttributeName: UIFont.init(name: "Avenir-Black", size: 14)!]
        
        fetchBrands()
    }
    
    func fetchBrands() {
        let accounts = [
            "isseymiyake__",
            "adidasy3",
            "yohjiyamamotoofficial",
            "sacaiofficial",
            "commedesgarcons",
            "kolorofficial",
            "loungelizard_official",
            "scye_official",
            "christiandada"
        ]
        
        for account in accounts {
            let request = IGBrandRequest(username: account)
            Session.send(request) { [weak self] result in
                switch result {
                case .success(_):
                    print("success")
                    if account == accounts.last {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
}
