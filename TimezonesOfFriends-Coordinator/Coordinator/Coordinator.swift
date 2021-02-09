//
//  Coordinator.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 09/02/2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
