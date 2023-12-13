//
//  FollowerRouter.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs

protocol FollowerInteractable:
    Interactable,
    FollowerListListener,
    FollowerDetailListener
{
    var router: FollowerRouting? { get set }
    var listener: FollowerListener? { get set }
    
    ///인터랙터에 보낼 디펜던시
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol FollowerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class FollowerRouter: Router<FollowerInteractable>, FollowerRouting {
    
    func attachFollowerList() {
        if followerListRouting != nil { return }
        let router = followerListBuildable.build(withListener: interactor)
        
        if navigationControllable != nil {
            navigationControllable?.pushViewController(router.viewControllable, animated: true)
        } else {
            presentInsideNavigation(router.viewControllable)
        }
        
        attachChild(router)
        self.followerListRouting = router
    }
    
    func detachFollowerList() {
        guard let router = followerListRouting else { return }
        
        dismissPresentedNavigation(completion: nil)
        
        detachChild(router)
        self.followerListRouting = nil
    }
    
    func attachFollowerDetail() {
        if followerDetailRouting != nil { return }
        let router = followerDetailBuildable.build(withListener: interactor)
        
        if navigationControllable != nil {
            navigationControllable?.pushViewController(router.viewControllable, animated: true)
        } else {
            presentInsideNavigation(router.viewControllable)
        }
        
        attachChild(router)
        self.followerDetailRouting = router
    }
    
    func detachFollowerDetail() {
        guard let router = followerDetailRouting else { return }
        
        if navigationControllable != nil {
            navigationControllable?.popViewController(animated: true)
        } else {
            dismissPresentedNavigation(completion: nil)
        }
        
        detachChild(router)
        self.followerDetailRouting = nil
    }
    
    /// 네비게이션에 묶어서 노출하려 할 때
    private func presentInsideNavigation(_ viewControllable: ViewControllable) {
        let navigation = NavigationControllable(root: viewControllable)
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        self.navigationControllable = navigation
        viewController.present(navigation, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        if self.navigationControllable == nil { return }
        viewController.dismiss(completion: nil)
        self.navigationControllable = nil
    }

    // 네비게이션컨트롤러로 루트 감쌀때 사용
    private var navigationControllable: NavigationControllable?
    
    private let followerListBuildable: FollowerListBuildable
    private var followerListRouting: FollowerListRouting?
    
    private let followerDetailBuildable: FollowerDetailBuildable
    private var followerDetailRouting: FollowerDetailRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: FollowerInteractable,
        viewController: ViewControllable,
        followerListBuildable: FollowerListBuildable,
        followerDetailBuildable: FollowerDetailBuildable
    ) {
        self.followerListBuildable = followerListBuildable
        self.followerDetailBuildable = followerDetailBuildable
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: ViewControllable
}
