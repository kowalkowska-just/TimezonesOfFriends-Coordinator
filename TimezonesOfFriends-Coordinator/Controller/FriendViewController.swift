//
//  FriendViewController.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 05/02/2021.
//

import UIKit

class FriendViewController: UITableViewController {

    //MARK: - Properties
    
    weak var delegate: ViewController?
    var friend: Friend!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
