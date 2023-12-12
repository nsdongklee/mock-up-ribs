//
//  RootRouter.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs

protocol RootInteractable:
    Interactable,
    HomeListener
{
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    /// 탭바 하위 뷰컨트롤러 세팅
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    func attachTabBars() {
        let homeRouting = homeBuildable.build(withListener: interactor)
        
        attachChild(homeRouting)
        
        self.homeRouting = homeRouting
        
        let tabs = [
            NavigationControllable(root: homeRouting.viewControllable)
        ]
        
        viewController.setViewControllers(tabs)
    }
    
    
    // TODO: Constructor inject child builder protocols to allow building children.
    
    private var homeRouting: HomeRouting?
    private let homeBuildable: HomeBuildable
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        homeBuildable: HomeBuildable
    ) {
        self.homeBuildable = homeBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
