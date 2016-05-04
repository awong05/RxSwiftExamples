//
//  ViewController.swift
//  ColorfulBall
//
//  Created by Andy Wong on 5/3/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxCocoa
import RxSwift

class ViewController: UIViewController
{
    var circleView: UIView!
    var circleViewModel: CircleViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = UIColor.greenColor()
        view.addSubview(circleView)

        circleViewModel = CircleViewModel()
        circleView
            .rx_observe(CGPoint.self, "center")
            .bindTo(circleViewModel.centerVariable)
            .addDisposableTo(disposeBag)

        circleViewModel.backgroundColorObservable
            .subscribeNext { [weak self] (backgroundColor) in
                UIView.animateWithDuration(0.1) {
                    self?.circleView.backgroundColor = backgroundColor
                    let viewBackgroundColor = UIColor.init(complementaryFlatColorOf: backgroundColor, withAlpha: 1.0)
                    if viewBackgroundColor != backgroundColor {
                        self?.view.backgroundColor = viewBackgroundColor
                    }
                }
            }
            .addDisposableTo(disposeBag)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    func circleMoved(recognizer: UIPanGestureRecognizer) {
        let location = recognizer.locationInView(view)
        UIView.animateWithDuration(0.1) {
            self.circleView.center = location
        }
    }

}

