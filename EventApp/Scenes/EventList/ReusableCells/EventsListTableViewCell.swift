//
//  EventsListTableViewCell.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

class EventsListTableViewCell: UITableViewCell {

    @IBOutlet weak var eventsDateLabel: UILabel!
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var eventsNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
