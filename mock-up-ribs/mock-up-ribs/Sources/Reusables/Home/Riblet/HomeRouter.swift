//
//  HomeRouter.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs

protocol HomeInteractable:
    Interactable,
    FollowerListener,
    LoginListener
{
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private var loginNavigationControllable: NavigationControllable?
    
    func attachLogin() {
        if loginRouting != nil { return }
        let router = loginBuildable.build(withListener: interactor)
        
        loginNavigationControllable = NavigationControllable(root: router.viewControllable)
        if let navigation = loginNavigationControllable {
            viewControllable.present(navigation, animated: true, completion: nil)
        }
        
        attachChild(router)
        self.loginRouting = router
    }
    
    func detachLogin() {
        guard let router = loginRouting else { return }
        
        loginNavigationControllable?.dismiss(completion: {})
        loginNavigationControllable = nil
        
        detachChild(router)
        self.loginRouting = nil
    }
    
    func attachFollowers() {
        if followerRouting != nil { return }
        let router = followerBuildable.build(withListener: interactor)
        attachChild(router)
        self.followerRouting = router
    }
    
    func detachFollowers() {
        guard let router = followerRouting else { return }
        detachChild(router)
        self.followerRouting = nil
    }

    private let loginBuildable: LoginBuildable
    private var loginRouting: LoginRouting?
    
    private let followerBuildable: FollowerBuildable
    private var followerRouting: FollowerRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        followerBuildable: FollowerBuildable,
        loginBuildable: LoginBuildable
    ) {
        self.loginBuildable = loginBuildable
        self.followerBuildable = followerBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
