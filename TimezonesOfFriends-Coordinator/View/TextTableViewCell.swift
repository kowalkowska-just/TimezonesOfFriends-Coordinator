//
//  TextTableViewCell.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 05/02/2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.placeholder = "Justyna Kowalkowska"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Helper Functions
    
    private func setupView() {
        contentView.addSubview(textField)
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
}
