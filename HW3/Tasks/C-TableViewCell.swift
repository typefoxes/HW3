//
//  C-TableViewCell.swift
//  HW3
//
//  Created by Fox on 11.09.2022.
//

import UIKit

class C_TableViewCell: UITableViewCell {
    
    static let identifier = "C-Cell"

    @IBOutlet weak var label: UILabel!
    
    func configure(with name: String) { label.text = name }

}
