//
//  ImagesObject.swift
//  WonUpItAssignment
//
//  Created by Gudisi, Sreekanth on 17/12/19.
//  Copyright © 2019 Gudisi, Sreekanth. All rights reserved.
//

import Foundation
import UIKit

class ImagesObject: NSObject {
    
    var indexOfVC = 0
    var imageOfVC = UIImage()
    var nameString = "First Name"
    var isSelectedOfVC = false
    var isImageAnimated = false
    var isAllSelectedOfVC = false
    
    var indexOfDetailsVC = 0
    var imageOfDetailsVC = UIImage()
    

    static func defaultImagesOfVC(with index: Int, append image: UIImage) -> ImagesObject {
        
        let payment = ImagesObject()
        payment.imageOfVC = image
        payment.indexOfVC = index
        return payment
    }
    
    static func defaultImagesOfDetailsVC(with index: Int, append image: UIImage) -> ImagesObject {
        
        let payment = ImagesObject()
        payment.imageOfDetailsVC = image
        payment.indexOfDetailsVC = index
        return payment
    }
}
