//
//  TableViewCell.swift
//  WonUpItAssignment
//
//  Created by Gudisi, Sreekanth on 17/12/19.
//  Copyright © 2019 Gudisi, Sreekanth. All rights reserved.
//

import UIKit

// MARK:- DetailsDelegate
@objc protocol DetailsDelegate : NSObjectProtocol {
    
    func didSelect(at cell: TableViewCell, place sender: UIButton)
}

class TableViewCell: UITableViewCell {

    // Cell Outlets
    @IBOutlet weak var uiview: UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var tapButton: UIButton!
    
    // Cell Varibles
    weak var detailsDelegate : DetailsDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Tap Button
    @IBAction func tapButtonTapped(_ sender: UIButton) {
        
        if (self.detailsDelegate?.responds(to: #selector(DetailsDelegate.didSelect(at:place:))))! {
            
            // Set here
            self.detailsDelegate?.didSelect(at: self, place: sender)
        }
    }
}
