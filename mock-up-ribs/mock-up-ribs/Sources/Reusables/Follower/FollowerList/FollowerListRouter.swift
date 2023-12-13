//
//  FollowerListRouter.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs

protocol FollowerListInteractable: Interactable {
    var router: FollowerListRouting? { get set }
    var listener: FollowerListListener? { get set }
}

protocol FollowerListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FollowerListRouter: ViewableRouter<FollowerListInteractable, FollowerListViewControllable>, FollowerListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FollowerListInteractable, viewController: FollowerListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
