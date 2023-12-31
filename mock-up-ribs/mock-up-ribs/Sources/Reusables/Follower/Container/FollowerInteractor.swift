//
//  FollowerInteractor.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift

protocol FollowerRouting: Routing {
    func cleanupViews()
    
    func attachFollowerList()
    func detachFollowerList()
    func attachFollowerDetail(_ userInfo: UserModel)
    func detachFollowerDetail()
}

protocol FollowerListener: AnyObject {
    func followerModalDismiss()
}

final class FollowerInteractor: Interactor, FollowerInteractable, AdaptivePresentationControllerDelegate {
    
    func detailDidTapBack() {
        router?.detachFollowerDetail()
    }
    
    func followerListDidTapCell(id: Int?) {
        guard let id = id else { return }
        
        UserViewModel().user(id: id, completion: { [weak self] userInfo in
            if let userInfo = userInfo {
                self?.router?.attachFollowerDetail(userInfo)
            }
        })
    }
    
    func followerListDidTapBack() {
        router?.detachFollowerList()
        listener?.followerModalDismiss()
    }
    
    func presentationControllerDidDismiss() {
        router?.detachFollowerList()
        listener?.followerModalDismiss()
    }
    
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    weak var router: FollowerRouting?
    weak var listener: FollowerListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        
        router?.attachFollowerList()
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
}
