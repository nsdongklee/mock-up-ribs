//
//  FollowerDetailViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift
import UIKit

protocol FollowerDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class FollowerDetailViewController: UIViewController, FollowerDetailPresentable, FollowerDetailViewControllable {

    weak var listener: FollowerDetailPresentableListener?
}
