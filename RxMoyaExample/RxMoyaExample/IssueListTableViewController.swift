//
//  IssueListTableViewController.swift
//  RxMoyaExample
//
//  Created by Andy Wong on 5/4/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift

class IssueListTableViewController: UITableViewController
{
    @IBOutlet weak var searchBar: UISearchBar!

    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<GitHub>!
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    var issueTrackerModel: IssueTrackerModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    func setupRx() {
        provider = RxMoyaProvider<GitHub>()

        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
    
        issueTrackerModel
            .trackIssues()
            .bindTo(tableView.rx_itemsWithCellFactory) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCellWithIdentifier("issueCell", forIndexPath: NSIndexPath(forRow: row, inSection: 0))
                cell.textLabel?.text = item.title

                return cell
            }
            .addDisposableTo(disposeBag)

        tableView
            .rx_itemSelected
            .subscribeNext { indexPath in
                if self.searchBar.isFirstResponder() == true {
                    self.view.endEditing(true)
                }
            }
            .addDisposableTo(disposeBag)
    }

}
