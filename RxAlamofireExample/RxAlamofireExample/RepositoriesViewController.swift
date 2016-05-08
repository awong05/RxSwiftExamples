//
//  RepositoriesViewController.swift
//  RxAlamofireExample
//
//  Created by Andy Wong on 5/7/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import UIKit
import ObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

class RepositoriesViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var rx_searchBarText: Observable<String> {
        return searchBar
            .rx_text
            .filter { $0.characters.count > 0 }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        
    }
}
