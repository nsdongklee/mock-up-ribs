//
//  FollowerDetailRouter.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs

protocol FollowerDetailInteractable: Interactable {
    var router: FollowerDetailRouting? { get set }
    var listener: FollowerDetailListener? { get set }
}

protocol FollowerDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FollowerDetailRouter: ViewableRouter<FollowerDetailInteractable, FollowerDetailViewControllable>, FollowerDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FollowerDetailInteractable, viewController: FollowerDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
