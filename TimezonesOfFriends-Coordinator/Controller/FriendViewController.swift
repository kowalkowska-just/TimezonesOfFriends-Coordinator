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
    
    var timeZones = [TimeZone]()
    var selectedtimeZone = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifiers = TimeZone.knownTimeZoneIdentifiers
        
        for identifier in identifiers {
            if let timeZone = TimeZone(identifier: identifier) {
                timeZones.append(timeZone)
            }
        }
        
        let now = Date()
        
        timeZones.sort {
            let ourDifference = $0.secondsFromGMT(for: now)
            let otherDifference = $1.secondsFromGMT(for: now)
            
            if ourDifference == otherDifference {
                return $0.identifier < $1.identifier
            } else {
                return ourDifference < otherDifference
            }
        }
        
        selectedtimeZone = timeZones.index(of: friend.timeZone) ?? 0
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        
    }
    
    //MARK: - TableView Delegate and DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timeZones.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Name your friend"
        } else {
            return "Select their timezone"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath) as? TextTableViewCell
            else {
                fatalError("Couldn't get a text table view cell.")
            }
            
            cell.textField.text = friend.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeZone", for: indexPath)
            let timeZone = timeZones[indexPath.row]
            cell.textLabel?.text = timeZone.identifier
            
            let timeDifference = timeZone.secondsFromGMT(for: Date())
            cell.detailTextLabel?.text = String(timeDifference)
            
            if indexPath.row == selectedtimeZone {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
        }
    }
}
