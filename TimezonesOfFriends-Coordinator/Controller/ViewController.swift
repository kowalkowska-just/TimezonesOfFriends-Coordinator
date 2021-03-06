//
//  ViewController.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 05/02/2021.
//

import UIKit

class ViewController: UITableViewController, Storyboarded {

    //MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Zone","Time"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange(_:)), for: .valueChanged)
        return sc
    }()
    
    private var friends = [Friend]()
    var selectedFriend: Int? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        loadData()
    }
    
    //MARK: - Helper Functions
    
    private func setupNavigationController() {
        title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        navigationController?.navigationBar.addSubview(segmentedControl)
        segmentedControl.anchor(bottom: navigationController?.navigationBar.bottomAnchor, right: navigationController?.navigationBar.rightAnchor, paddingBottom: 15, paddingRight: 20)
        segmentedControl.clipsToBounds = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Selectors
    
    @objc private func addFriend() {
        let friend = Friend()
        friends.append(friend)
        
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        selectedFriend = friends.count - 1
        coordinator?.configure(friend: friend)
    }
    
    @objc private func handleSegmentChange(_ sender: UISegmentedControl) {
        
        print("DEBUG: Change value in segment control is called")
        
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate and DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name

        let index = segmentedControl.selectedSegmentIndex

        if index == 0 {
             cell.detailTextLabel?.text = friend.timeZone.identifier
        } else {
            cell.detailTextLabel?.text = timeNumeric(from: friend)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = indexPath.row
        coordinator?.configure(friend: friends[indexPath.row])
    }
    
    // MARK: - Swipe to delete UITableViewCells
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.updateModel(at: indexPath)
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        return action
    }
    
    func updateModel(at indexPath: IndexPath) {
        friends.remove(at: indexPath.row)
        tableView.reloadData()
        saveData()
    }
    
    //MARK: - Load Data
    
    private func loadData() {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.data(forKey: "Friends") else { return }
        
        let decoder = JSONDecoder()
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else { return }
        
        friends = savedFriends
    }
    
    //MARK: - Save Data
    
    private func saveData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(friends) else {
            fatalError("Unable to encode friends data")
        }
        
        defaults.setValue(savedData, forKey: "Friends")
    }
    
    //MARK: - Configure FriendViewController
    
    func update(friend: Friend) {
        guard let selectedFriend = selectedFriend else { return }
        friends[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }
}

