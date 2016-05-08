//
//  RepositoryNetworkModel.swift
//  RxAlamofireExample
//
//  Created by Andy Wong on 5/7/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import ObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

struct RepositoryNetworkModel {
    lazy var rx_repositories: Driver<[Repository]> = self.fetchRepositories()
    private var repositoryName: Observable<String>

    init(withNameObservable nameObservable: Observable<String>) {
        self.repositoryName = nameObservable
    }

    private func fetchRepositories() -> Driver<[Repository]> {
        return repositoryName
            .flatMapLatest { text in
                return RxAlamofire
                    .requestJSON(.GET, "https://api.github.com/users/\(text)/repos")
                    .debug()
                    .catchError { error in
                        return Observable.never()
                    }
            }
            .map { (response, json) -> [Repository] in
                if let repos = Mapper<Repository>().mapArray(json) {
                    return repos
                } else {
                    return []
                }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
