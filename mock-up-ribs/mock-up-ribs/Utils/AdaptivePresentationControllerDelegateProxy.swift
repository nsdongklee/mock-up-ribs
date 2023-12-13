//
//  AdaptivePresentationControllerDelegateProxy.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import UIKit

//MARK: - 화면 드래그 다운으로 빠져나오는 것을 콜백으로 받는 델리게이트 -> 커스텀 클래스 내에 델리게이트로 감싸서 들고 가기
protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {

    weak var delegate: AdaptivePresentationControllerDelegate?

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}

