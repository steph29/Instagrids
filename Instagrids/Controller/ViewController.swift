//
//  ViewController.swift
//  Instagrids
//
//  Created by stephane verardo on 03/01/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelSwipeView: UIStackView!
    @IBOutlet weak var viewSwiped: UIView!
    @IBOutlet weak var imageViewtag3: UIImageView!
    @IBOutlet weak var squareHighLeft: UIView!
    @IBOutlet weak var squareHighRight: UIView!
    @IBOutlet weak var squareLowLeft: UIView!
    @IBOutlet weak var squareLowRight: UIView!
    @IBOutlet weak var rectangleHigh: UIView!
    @IBOutlet weak var rectangleLow: UIView!
    @IBOutlet weak var checkMarkButtonLeft: UIButton!
    @IBOutlet weak var checkMarkButtonMiddle: UIButton!
    @IBOutlet weak var checkMarkButtonRight: UIButton!
    @IBOutlet weak var squareLowStackView: UIStackView!
    @IBOutlet weak var squareHighStackView: UIStackView!
    @IBOutlet weak var RectangleHighButton: UIButton!
    var imagePicker = UIImagePickerController()
    var imageChoisie = UIImageView()
    var tagBool: Bool = false
    
    // MARK - defined checkMarkButton action
    
    @IBAction func checkMarkLeft(_ sender: Any) {
        ItemsShowed(firstButton: checkMarkButtonLeft, firstImage: rectangleHigh, stackView: squareLowStackView)
        ItemsHidden(firstButton: checkMarkButtonMiddle, secondButton: checkMarkButtonRight, firstImage: rectangleLow, stackView: squareHighStackView)
        
    }
    
    @IBAction func checkMarkMiddle(_ sender: Any) {
        ItemsShowed(firstButton: checkMarkButtonMiddle, firstImage: rectangleLow, stackView: squareHighStackView)
        checkMarkButtonLeft.imageView?.isHidden = true
        checkMarkButtonRight.imageView?.isHidden = true
        rectangleHigh.isHidden = true
        // ItemsHidden(firstButton: checkMarkButtonLeft, secondButton: checkMarkButtonRight, firstImage: rectangleHigh, stackView: squareLowStackView)
    }
    
    @IBAction func checkMarkRight(_ sender: Any) {
        ItemsShowedStackViewOnly(firstButton: checkMarkButtonMiddle, firstStackView: squareHighStackView, secondStackView: squareLowStackView)
        ItemsHiddenStackViewOnly(firstButton: checkMarkButtonLeft, secondButton: checkMarkButtonMiddle, firstImage: rectangleLow, secondImage: rectangleHigh)
    }
    
    // Mark - function to change the format of the picture
    private func ItemsShowedStackViewOnly(firstButton: UIButton,  firstStackView: UIStackView, secondStackView: UIStackView){
        firstButton.imageView?.isHidden = false
        firstStackView.isHidden = false
        secondStackView.isHidden = false
    }
    
    private func ItemsHiddenStackViewOnly(firstButton: UIButton, secondButton: UIButton,  firstImage: UIView, secondImage: UIView){
        firstButton.imageView?.isHidden = true
        secondButton.imageView?.isHidden = true
        firstImage.isHidden = true
        secondImage.isHidden = true
    }
    
    private func ItemsShowed(firstButton: UIButton,  firstImage: UIView, stackView: UIStackView){
        firstButton.imageView?.isHidden = false
        firstImage.isHidden = false
        stackView.isHidden = false
    }
    
    private func ItemsHidden(firstButton: UIButton, secondButton: UIButton,  firstImage: UIView, stackView: UIStackView){
        firstButton.imageView?.isHidden = true
        secondButton.imageView?.isHidden = true
        firstImage.isHidden = true
        stackView.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMarkLeft(self)
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        UIView.animate(withDuration: 0.6) {
       
            
            self.viewSwiped.center.x += self.view.bounds.width
        self.labelSwipeView.center.x -= self.view.bounds.width
        self.checkMarkButtonRight.center.x += self.view.bounds.width
            UIView.animate(withDuration: 0.5, delay: 0.3, options: [],
                           animations: {
                            self.checkMarkButtonMiddle.center.x += self.view.bounds.width
                            UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: {
                                self.checkMarkButtonLeft.center.x += self.view.bounds.width
                            }, completion: nil)
                                        },
                           completion: nil
            )
        }
    }
  
    // MARK - Connection to the library
    @IBAction func prendrePhoto11(_ sender: Any) {
        imageChoisie = squareHighLeft.viewWithTag(1) as! UIImageView
        capturePicture()
    }
    
    @IBAction func prendrePhoto2(_ sender: Any) {
        imageChoisie = squareHighRight.viewWithTag(2) as! UIImageView
        capturePicture()
    }
    
    @IBAction func prendrePhoto1(_ sender: Any) {
        imageChoisie = squareLowLeft.viewWithTag(3) as! UIImageView
        capturePicture()
        }
    
    @IBAction func prendrePhoto4(_ sender: Any) {
        imageChoisie = squareLowRight.viewWithTag(4) as! UIImageView
        capturePicture()
    }
    @IBAction func prendrePhoto5(_ sender: Any) {
        imageChoisie = rectangleHigh.viewWithTag(5) as! UIImageView
        capturePicture()
    }
    @IBAction func prendrePhoto6(_ sender: Any) {
        imageChoisie = rectangleLow.viewWithTag(6) as! UIImageView
        capturePicture()
    }
 
    func presentWithSource(_ source: UIImagePickerController.SourceType)  {
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func capturePicture() {
        let alerteActionSheet = UIAlertController(title: "Prendre un photo", message: "Choisissez le média", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.presentWithSource(.camera)
            } else {
                let alerte = UIAlertController(title: "Erreur", message: "Aucun appareil photo n'est disponible", preferredStyle: .alert)
                let annuler = UIAlertAction(title: "Je comprends", style: .destructive, handler: nil)
                alerte.addAction(annuler)
                self.present(alerte, animated: true, completion: nil)
            }
            
        }
        let gallery = UIAlertAction(title: "Gallerie de photos", style: .default) { (action) in
            self.presentWithSource(.photoLibrary)
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alerteActionSheet.addAction(camera)
        alerteActionSheet.addAction(gallery)
        alerteActionSheet.addAction(cancel)
        
        if let popover = alerteActionSheet.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.frame.midX, y: view.frame.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(alerteActionSheet, animated: true, completion: nil)
    }
    
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edite = info[.editedImage] as? UIImage {
            imageChoisie.image = edite
        } else if let originale = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageChoisie.image = originale
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}




