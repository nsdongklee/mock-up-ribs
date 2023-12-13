//
//  HomeRouter.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs

protocol HomeInteractable:
    Interactable,
    FollowerListener
{
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
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

    
    private let followerBuildable: FollowerBuildable
    private var followerRouting: FollowerRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        followerBuildable: FollowerBuildable
    ) {
        self.followerBuildable = followerBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
