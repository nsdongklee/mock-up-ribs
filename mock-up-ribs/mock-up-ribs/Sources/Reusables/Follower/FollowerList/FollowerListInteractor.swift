//
//  FollowerListInteractor.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift

protocol FollowerListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FollowerListPresentable: Presentable {
    var listener: FollowerListPresentableListener? { get set }
    
    var viewModel: UserViewModel { get }
}

protocol FollowerListListener: AnyObject {
    func followerListDidTapBack()
}

final class FollowerListInteractor: PresentableInteractor<FollowerListPresentable>, FollowerListInteractable, FollowerListPresentableListener {
    
    func didTapBackButton() {
        listener?.followerListDidTapBack()
    }
    
    private func initialize() {
        
    }

    weak var router: FollowerListRouting?
    weak var listener: FollowerListListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FollowerListPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
