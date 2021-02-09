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
        tf.autocorrectionType = .no
        tf.keyboardAppearance = .dark
        return tf
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
