//
//  TableViewController.swift
//  CitySearcher
//
//  Created by Andy Wong on 5/3/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TableViewController: UITableViewController
{
    @IBOutlet weak var searchBar: UISearchBar!

    private var shownCities = [String]()
    private let allCities = ["New York",
                     "London",
                     "Oslo",
                     "Warsaw",
                     "Berlin",
                     "Praga"]
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { $0.characters.count > 0 }
            .subscribeNext { [unowned self] (query) in
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            }
            .addDisposableTo(disposeBag)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityPrototypeCell", forIndexPath: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]

        return cell
    }

}
