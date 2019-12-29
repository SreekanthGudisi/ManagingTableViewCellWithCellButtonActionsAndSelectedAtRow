//
//  DetailsViewController.swift
//  WonUpItAssignment
//
//  Created by Gudisi, Sreekanth on 17/12/19.
//  Copyright © 2019 Gudisi, Sreekanth. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // Class Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickedCardLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var selectedIndexUIView: UIView!
    @IBOutlet weak var selectedIndexLabel: UILabel!
    

    // Class Varibles
    var imagesObject = [ImagesObject]()
    var isbuttonSelected = false
    
    // ViewDidAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Initial Method
        initialMethod()
    }

    // ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Call Animations
        animations()
    }
    
    @IBAction func selectAllButtonTapped(_ sender: Any) {

        isbuttonSelected = !isbuttonSelected
        if !isbuttonSelected  {
            
            selectAllButton.setTitle("Deselect all", for: .normal)
            selectedIndexLabel.text = "All cards are selected"
            selectedIndexUIView.isHidden = false
            tableView.reloadData()
        } else {
            
            selectAllButton.setTitle("Select all", for: .normal)
            selectedIndexLabel.text = "All cards are Deselected"
            selectedIndexUIView.isHidden = true
            tableView.reloadData()
        }
    }
    
    // Close Button
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK:-  TableView
extension DetailsViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imagesObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isbuttonSelected == false {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cell.imagesObject = imagesObject[indexPath.row]
            cell.setupSelectCell()
            selectedIndexUIView.isHidden = false
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cell.imagesObject = imagesObject[indexPath.row]
            if cell.imagesObject.isSelectedOfVC == true {
                cell.setupSelectCell()
            } else {
                cell.setupDefaultCell()
            }
            selectedIndexUIView.isHidden = true
            return cell
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        // RotationTranform from right to left
//        let rotationTranform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 100)
//        cell.layer.transform = rotationTranform
//        cell.alpha = 0.5
//        UIView.animate(withDuration: 2.0) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//            if self.isbuttonSelected == false {
//                self.selectedIndexUIView.isHidden = false
//            }else {
//                UIView.animate(withDuration: 0.7) {
//                    self.selectedIndexUIView.isHidden = true
//                }
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let imageObject = imagesObject[indexPath.row]
        if isbuttonSelected == false {
            imageObject.isSelectedOfVC = false
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: "Please Deselect All Images", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        } else {
            
            imageObject.isSelectedOfVC = true
            let cell = tableView.cellForRow(at: indexPath) as? DetailsTableViewCell
            if cell != nil {
                cell!.imagesObject = imageObject
                cell!.setupSelectCell()
            }
            selectedIndexUIView.isHidden = false
            selectedIndexLabel.text = "Card number " + "\(indexPath.row + 1)" + " selected"
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let imageObject = imagesObject[indexPath.row]
        imageObject.isSelectedOfVC = false
        
        let cell = tableView.cellForRow(at: indexPath) as? DetailsTableViewCell
        if cell != nil {
            cell!.imagesObject = imageObject
            cell!.setupDefaultCell()
        }
        selectedIndexUIView.isHidden = true
        selectedIndexLabel.text = "Card number " + "\(indexPath.row + 1)" + " selected"
    }
}

//MARK:- Functions
extension DetailsViewController {
    
    private func initialMethod() {

        // Manage isbuttonSelected
        isbuttonSelected = true
        
        // Tableview Set Delegate And DataSource
        tableViewSetup()

        // Call setupImages
        setupImages()
        
        // Managing Selected UIView
        selectedIndexUIView.isHidden = true
    }
    
    // Create Animations
    func animations() {
        
        // Title Label
        let titleLabelOriginalFrame: CGRect = titleLabel.frame
        var pickedCardLabelChangedFrame: CGRect = pickedCardLabel.frame
        pickedCardLabelChangedFrame.origin.y = 30
        titleLabel.frame = pickedCardLabelChangedFrame
        UIView.animate(withDuration: 0.5, animations: {
            
            self.titleLabel.alpha = 1.0
            self.titleLabel.frame = titleLabelOriginalFrame
        }) { (finished) in
            //Do something
            if finished {
            }
        }
        
        // Welcome Label
        let pickedCardLabelOriginalFrame: CGRect = pickedCardLabel.frame
        var titleLabelChangedFrame: CGRect = titleLabel.frame
        titleLabelChangedFrame.origin.x = -200
        pickedCardLabel.frame = titleLabelChangedFrame
        UIView.animate(withDuration: 0.5, animations: {
            
            self.pickedCardLabel.alpha = 1.0
            self.pickedCardLabel.frame = pickedCardLabelOriginalFrame
        }) { (finished) in
            //Do something
            if finished {
            }
        }
        
        // Selected Button
        let selectAllButtonOriginalFrame: CGRect = selectAllButton.frame
        var pickedCardLabelChangedFrame1: CGRect = titleLabel.frame
        pickedCardLabelChangedFrame1.origin.x = -100
        selectAllButton.frame = pickedCardLabelChangedFrame1
        UIView.animate(withDuration: 0.5, animations: {
            
            self.selectAllButton.alpha = 1.0
            self.selectAllButton.frame = selectAllButtonOriginalFrame
        }) { (finished) in
            //Do something
            if finished {
            }
        }
    }
    
    // TableViewSetUp
    private func tableViewSetup()  {
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Call setupImages
    private func setupImages() {
        
        for i in 0...99 {

            imagesObject.append(ImagesObject.defaultImagesOfDetailsVC(with: i+1, append: UIImage(named: "Places.png")!))
        }
    }
}
