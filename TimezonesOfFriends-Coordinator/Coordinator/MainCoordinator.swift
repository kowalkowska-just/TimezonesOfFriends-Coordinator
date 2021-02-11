//
//  MainCoordinator.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 09/02/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func configure(friend: Friend) {
        let vc =  FriendViewController.instantiate()

        vc.coordinator = self
        vc.friend = friend
        navigationController.pushViewController(vc, animated: true)
    }
    
    func update(friend: Friend) {
        guard let vc = navigationController.viewControllers.first as? ViewController else { return }
        vc.update(friend: friend)
        navigationController.isNavigationBarHidden = false
        navigationController.popToViewController(vc, animated: true)

    }

}
