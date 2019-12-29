//
//  ViewController.swift
//  WonUpItAssignment
//
//  Created by Gudisi, Sreekanth on 17/12/19.
//  Copyright © 2019 Gudisi, Sreekanth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    // Class Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // Class Varibles
    var imagesObject = [ImagesObject]()
    let transitionViewController = TransitionViewController()
    
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
        // TableView Reload
        tableView.reloadData()
    }
}

// MARK:-  TableView
extension ViewController : UITableViewDelegate, UITableViewDataSource, DetailsDelegate {
    
    func didSelect(at cell: TableViewCell, place sender: UIButton) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            let imageObject = imagesObject[indexPath.row]
            if imageObject.isImageAnimated == false {
                animateCellImage(cell: cell, at: indexPath)
            } else {
                animateCellImageToDefault(cell: cell, at: indexPath)
            }
        }
    }
    
    private func defaultCellImage(cell: TableViewCell, at indexPath: IndexPath) {
        
        let imageObject = imagesObject[indexPath.row]
        if imageObject.isImageAnimated == false {
            cell.tapButton.backgroundColor = .red
        } else {
            cell.tapButton.backgroundColor = .gray
        }
    }
    
    private func animateCellImage(cell: TableViewCell, at indexPath: IndexPath) {
        
        let imageObject = imagesObject[indexPath.row]
        imageObject.isImageAnimated = true
        cell.tapButton.backgroundColor = .gray
        let image = UIImage(named: "Empty-Image.png")
        cell.imageview?.image = image
        UIView.transition(with: cell.imageview!
            , duration: 1, options: .transitionFlipFromLeft, animations: {
        }) { (completion) in
        }
    }
    
    private func animateCellImageToDefault(cell: TableViewCell, at indexPath: IndexPath) {
        
        let imageObject = imagesObject[indexPath.row]
        imageObject.isImageAnimated = false
        cell.tapButton.backgroundColor = .red
        let image = UIImage(named: "Diamond.png")
        cell.imageview.image = image
        UIView.transition(with: cell.imageview, duration: 1, options: .transitionFlipFromBottom, animations: {
        }) { (completion) in
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 240
    }

    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        return 240
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imagesObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.imageview.image = imagesObject[indexPath.row].imageOfVC
        cell.nameButton.setTitle(imagesObject[indexPath.row].nameString, for: .normal)
        cell.detailsDelegate = self
        defaultCellImage(cell: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // RotationTranform from left to right
        let rotationTranform = CATransform3DTranslate(CATransform3DIdentity, -300, 0, 0)
        cell.layer.transform = rotationTranform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        if cell?.imageview.image == UIImage(named: "Empty-Image.png") {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: "Please Flip The Image", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        } else {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

//MARK:- Functions
extension ViewController {
    
    private func initialMethod() {

        // Tableview Set Delegate And DataSource
        tableViewSetup()

        // Call pageSetup
        setupImages()
        
        // Transition Deleaget
        navigationController?.delegate = self
    }
    
    // Create Animations
    func animations() {
        
        // Title Label
        let titleLabelOriginalFrame: CGRect = titleLabel.frame
        var welcomeLabelChangedFrame: CGRect = welcomeLabel.frame
        welcomeLabelChangedFrame.origin.y = 30
        titleLabel.frame = welcomeLabelChangedFrame
        UIView.animate(withDuration: 0.5, animations: {
            
            self.titleLabel.alpha = 1.0
            self.titleLabel.frame = titleLabelOriginalFrame
        }) { (finished) in
            //Do something
            if finished {
            }
        }
        
        // Welcome Label
        let welcomeLabelOriginalFrame: CGRect = welcomeLabel.frame
        var titleLabelChangedFrame: CGRect = titleLabel.frame
        titleLabelChangedFrame.origin.x = -200
        welcomeLabel.frame = titleLabelChangedFrame
        UIView.animate(withDuration: 0.5, animations: {
            
            self.welcomeLabel.alpha = 1.0
            self.welcomeLabel.frame = welcomeLabelOriginalFrame
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
    
    private func setupImages() {
        
        for i in 0...49 {

            imagesObject.append(ImagesObject.defaultImagesOfVC(with: i+1, append: UIImage(named: "Diamond.png")!))
        }
    }
    
    internal func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        transitionViewController.popStyle = (operation == .pop)
        return transitionViewController
    }
}
