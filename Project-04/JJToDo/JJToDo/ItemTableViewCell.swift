//
//  ItemTableViewCell.swift
//  JJToDo
//
//  Created by admin on 2019/8/16.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
 
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(with Item: ToDoItem, isChecked: Bool = false) {
        if isChecked {
            let attributedString = NSAttributedString(string: Item.title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel.text = nil
            locationLabel.text = nil
        } else {
            titleLabel.text = Item.title
            if let timestamp = Item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
            
            if let location = Item.location {
                locationLabel.text = location.name
            }
        }
    }
}
