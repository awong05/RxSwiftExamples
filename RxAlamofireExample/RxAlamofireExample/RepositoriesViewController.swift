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
    let disposeBag = DisposeBag()
    var repositoryNetworkModel: RepositoryNetworkModel!

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
        repositoryNetworkModel = RepositoryNetworkModel(withNameObservable: rx_searchBarText)

        repositoryNetworkModel
            .rx_repositories
            .drive(tableView.rx_itemsWithCellFactory) { (tv, i, repository) in
                let cell = tv.dequeueReusableCellWithIdentifier("repositoryCell", forIndexPath: NSIndexPath(forRow: i, inSection: 0))
                cell.textLabel?.text = repository.name

                return cell
            }
            .addDisposableTo(disposeBag)

        repositoryNetworkModel
            .rx_repositories
            .driveNext { repositories in
                if repositories.count == 0 {
                    let alert = UIAlertController(title: ":(", message: "No repositories for this user.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    if self.navigationController?.visibleViewController?.isMemberOfClass(UIAlertController.self) != true {
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
            .addDisposableTo(disposeBag)
    }
}
