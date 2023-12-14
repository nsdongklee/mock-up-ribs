//
//  LoginInteractor.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import RIBs
import RxSwift

protocol LoginRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
    
    var viewModel: LoginViewModel { get }
}

protocol LoginListener: AnyObject {
    func loginDidTapBack()
    func loginSuccessfully()
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {
    
    func didTapLogin() {
        presenter.viewModel.login(
            id: presenter.viewModel.inputID(),
            pw: presenter.viewModel.inputPW(),
            completion: { [weak self] userInfo in
                if userInfo != nil {
                    self?.listener?.loginSuccessfully()
                }
            })
    }
    
    func checkInput(id: String?) {
        presenter.viewModel.checkInput(id: id)
    }
    
    func checkInput(pw: String?) {
        presenter.viewModel.checkInput(pw: pw)
    }
    
    func didTapBackButton() {
        listener?.loginDidTapBack()
    }

    weak var router: LoginRouting?
    weak var listener: LoginListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoginPresentable) {
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
