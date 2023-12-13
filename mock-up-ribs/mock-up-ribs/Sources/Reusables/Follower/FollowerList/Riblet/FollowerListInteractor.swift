//
//  FollowerListInteractor.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift

protocol FollowerListRouting: ViewableRouting {
}

protocol FollowerListPresentable: Presentable {
    var listener: FollowerListPresentableListener? { get set }
    
    var viewModel: UserViewModel { get }
}

protocol FollowerListListener: AnyObject {
    func followerListDidTapBack()
    func followerListDidTapCell(id: Int?)
}

final class FollowerListInteractor: PresentableInteractor<FollowerListPresentable>, FollowerListInteractable, FollowerListPresentableListener {
    
    func didTapCell(id: Int?) {
        listener?.followerListDidTapCell(id: id)
    }
    
    func didTapBackButton() {
        listener?.followerListDidTapBack()
    }
    
    private func initialize() {
        presenter.viewModel.followers()
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
        
        initialize()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
