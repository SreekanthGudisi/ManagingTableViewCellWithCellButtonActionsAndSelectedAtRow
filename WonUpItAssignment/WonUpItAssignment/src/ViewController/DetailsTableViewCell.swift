//
//  DetailsTableViewCell.swift
//  WonUpItAssignment
//
//  Created by Gudisi, Sreekanth on 17/12/19.
//  Copyright © 2019 Gudisi, Sreekanth. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    // Cell Outlets
    @IBOutlet weak var uiview: UIView!
    @IBOutlet weak var imageview: UIImageView!
    
    // Cell Varibles
    var imagesObject = ImagesObject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupSelectCell() {
        imageview.image = imagesObject.imageOfDetailsVC.grayScaled
    }
    
    func setupDefaultCell() {
        imageview.image = imagesObject.imageOfDetailsVC
    }
}
