//
//  ReactView.swift
//  RxAlamofireExample
//
//  Created by Andy Wong on 5/11/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import UIKit
import React

class ReactView: UIView {
    let rootView: RCTRootView = RCTRootView(bundleURL: NSURL(string: "http://localhost:8081/React/index.ios.bundle?platform=ios"), moduleName: "App", initialProperties: nil, launchOptions: nil)

    override func layoutSubviews() {
        super.layoutSubviews()
        loadReact()
    }

    func loadReact() {
        addSubview(rootView)
        rootView.frame = self.bounds
        rootView.appProperties = ["body": "Testing"]
    }
}
