//
//  HomeViewModel.swift
//  Space
//
//  Created by bran.new on 2021/10/03.
//

import UIKit
import Combine

final class HomeViewModel {

    enum Navigation {
        case idle
        case whitehall
        case myPlanet
        case blackhall
    }

    enum Action {
        case appear
        case didTapWhitehall
        case didTapBlackhall
        case didTapMyPlanet
        case didTapBackButton
    }

    class State {
        var bottomSheet: CurrentValueSubject<Navigation, Never> = .init(.idle)
    }

    var action: PassthroughSubject<Action, Never> = .init()
    var state: State = State()

    private var subscriptions: Set<AnyCancellable> = []

    init() {
        transform()
    }

    private func transform() {
        action.sink { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .appear: break
            case .didTapWhitehall:
                self.state.bottomSheet.send(.whitehall)
            case .didTapBlackhall:
                self.state.bottomSheet.send(.blackhall)
            case .didTapMyPlanet:
                self.state.bottomSheet.send(.myPlanet)
            case .didTapBackButton:
                self.state.bottomSheet.send(.idle)
            }
        }.store(in: &subscriptions)
    }
}
