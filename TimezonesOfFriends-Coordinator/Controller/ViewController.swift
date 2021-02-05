//
//  ViewController.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 05/02/2021.
//

import UIKit

class ViewController: UITableViewController {

    //MARK: - Properties
    
    private var friends = [Friend]()
    
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
    }
    
    //MARK: - Selectors
    
    @objc private func addFriend() {
        let friend = Friend()
        friends.append(friend)
        
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        
        configure(friend: friend, pasition: friends.count - 1)
    }
    
    //MARK: - TableView Delegate and DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.timeZone.identifier
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configure(friend: friends[indexPath.row], pasition: indexPath.row)
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
    
    private func configure(friend: Friend, pasition: Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as? FriendViewController else { fatalError("Unable to create FrienViewController.") }
        
        vc.delegate = self
        vc.friend = friend
        navigationController?.pushViewController(vc, animated: true)
    }
}

