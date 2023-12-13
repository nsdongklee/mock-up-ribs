//
//  HomeInteractor.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs
import RxSwift

protocol HomeRouting: ViewableRouting {
    func attachFollowers()
    func detachFollowers()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
}

protocol HomeListener: AnyObject {
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {

    func followerModalDismiss() {
        router?.detachFollowers()
    }
    
    func didTapFollowers() {
        router?.attachFollowers()
    }
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: HomePresentable) {
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
