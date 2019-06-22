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
    
    @IBOutlet weak var buttonImageHighLeft: UIButton!
    @IBOutlet weak var buttonLowLeft: UIButton!
    @IBOutlet weak var labelSwipeView: UIStackView!
    @IBOutlet weak var viewSwiped: UIView!
    @IBOutlet weak var squareHighLeft: UIView!
    @IBOutlet weak var squareHighRight: UIView!
    @IBOutlet weak var squareLowLeft: UIView!
    @IBOutlet weak var squareLowRight: UIView!
    @IBOutlet weak var checkMarkButtonLeft: UIButton!
    @IBOutlet weak var checkMarkButtonMiddle: UIButton!
    @IBOutlet weak var checkMarkButtonRight: UIButton!
    @IBOutlet weak var squareLowStackView: UIStackView!
    @IBOutlet weak var squareHighStackView: UIStackView!
    var imagePicker = UIImagePickerController() // image picking on librairie or on camera
    var lastTagButtonSelected = Int() // Tag of the button selected
    var imageLoaded1 = false // image from square High Left
    var imageLoaded2 = false // image from square High Right
    var imageLoaded3 = false // image from square low Left
    var imageLoaded4 = false // image from square low Right
    var checkMarkIsSelectedLeft = false // Boolean concerning the state of the selection of the button
    var checkMarkIsSelectedMiddle = false // Boolean concerning the state of the selection of the button
    var checkMarkIsSelectedRight = false // Boolean concerning the state of the selection of the button
    
    // MARK - defined checkMarkButton action
    @IBAction func checkMarkLeft(_ sender: Any) {
        checkMarkIsSelectedMiddle = false
        checkMarkIsSelectedRight = false
        checkMarkIsSelectedLeft = true
        viewSwiped.transform = .identity
        ItemsHidden(firstButton: checkMarkButtonMiddle, secondButton: checkMarkButtonRight, firstImage: squareHighRight)
        ItemsShowed(firstButton: checkMarkButtonLeft, firstImage: squareLowLeft, secondImage: squareLowRight)
        
    }
    
    @IBAction func checkMarkMiddle(_ sender: Any) {
        checkMarkIsSelectedMiddle = true
        checkMarkIsSelectedRight = false
        checkMarkIsSelectedLeft = false
        viewSwiped.transform = .identity
        ItemsHidden(firstButton: checkMarkButtonLeft, secondButton: checkMarkButtonRight, firstImage: squareLowRight)
        ItemsShowed(firstButton: checkMarkButtonMiddle, firstImage: squareHighLeft, secondImage: squareHighRight)
        
    }
    
    @IBAction func checkMarkRight(_ sender: Any) {
        checkMarkIsSelectedMiddle = false
        checkMarkIsSelectedRight = true
        checkMarkIsSelectedLeft = false
        viewSwiped.transform = .identity
        checkMarkButtonLeft.imageView?.isHidden = true
        checkMarkButtonMiddle.imageView?.isHidden = true
        squareLowRight.isHidden = false
        squareLowLeft.isHidden = false
        squareHighRight.isHidden = false
        squareHighLeft.isHidden = false
        
    }
    
    // Mark - function to change the position of the images
    private func StackViewShowed(firstStackView: UIStackView, secondStackView: UIStackView){
        firstStackView.isHidden = false
        firstStackView.isHidden = false
    }
    
    private func StackViewHidden(firstStackView: UIStackView, secondStackView: UIStackView) {
        firstStackView.isHidden = true
        firstStackView.isHidden = true
        
    }
    private func ItemsShowed(firstButton: UIButton,  firstImage: UIView, secondImage: UIView){
        firstButton.imageView?.isHidden = false
        firstImage.isHidden = false
        secondImage.isHidden = false
    }
    
    private func ItemsHidden(firstButton: UIButton, secondButton: UIButton,  firstImage: UIView){
        firstButton.imageView?.isHidden = true
        secondButton.imageView?.isHidden = true
        firstImage.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMarkLeft(self)
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        UIView.animate(withDuration: 0.5) {
            self.viewSwiped.center.x += self.view.bounds.width
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
    
    // MARK - Animation and Share
    func alertIsNotLoaded() {
        let alert = UIAlertController(title: "Pas si vite!", message: "Toutes les photos ne sont pas chargées", preferredStyle: .alert)
        let annuler = UIAlertAction(title: "Je comprends", style: .destructive, handler: nil)
        alert.addAction(annuler)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.viewSwiped)
        if UIApplication.shared.statusBarOrientation.isLandscape {
            viewSwiped.transform = CGAffineTransform(translationX: translation.x - 500 , y: 0)
        } else {
            viewSwiped.transform = CGAffineTransform(translationX: 0, y: translation.y - 350)
        }
        if recognizer.state == .ended {
            if (!IsLoaded()){
                alertIsNotLoaded()
                viewSwiped.transform = .identity
            }else {
                handleShare()
            }
            
        }
        
    }
    
    
    // function to share the content
    func handleShare() {
        UIGraphicsBeginImageContext(viewSwiped.bounds.size)
        viewSwiped.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    // MARK - Verify if all images are uploaded
    func IsLoaded() -> Bool {
        var isLoaded = false
        if (checkMarkIsSelectedLeft) {
            if (imageLoaded1 && imageLoaded3 && imageLoaded4) {
                isLoaded = true
            }
        }
        else if (checkMarkIsSelectedMiddle){
            if (imageLoaded1 && imageLoaded2 && imageLoaded3){
                isLoaded = true
            }
        } else if (checkMarkIsSelectedRight) {
            if (imageLoaded1 && imageLoaded2 && imageLoaded3 && imageLoaded4) {
                isLoaded = true
            }
        }
        return isLoaded
    }
    
    // MARK - button action to upload image
    @IBAction func prendrePhoto11(_ sender: Any) {
        capturePicture()
        lastTagButtonSelected = 1
        imageLoaded1 = true
    }
    
    @IBAction func prendrePhoto2(_ sender: Any) {
        capturePicture()
        lastTagButtonSelected = 2
        imageLoaded2 = true
    }
    
    @IBAction func prendrePhoto1(_ sender: Any) {
        capturePicture()
        lastTagButtonSelected = 3
        imageLoaded3 = true
    }
    
    @IBAction func prendrePhoto4(_ sender: Any) {
        capturePicture()
        lastTagButtonSelected = 4
        imageLoaded4 = true
    }
    
    // MARK - Connection to the camera or library
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
                let annuler = UIAlertAction(title: "Annuler", style: .destructive, handler: nil)
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
        let buttonToModify = self.view.viewWithTag(lastTagButtonSelected) as! UIButton
        if let edite = info[.editedImage] as? UIImage {
            buttonToModify.setImage(edite, for: .normal)
            buttonToModify.imageView!.contentMode = .scaleAspectFill
            buttonToModify.imageView!.layer.masksToBounds = true
        } else if let originale = info[.originalImage] as? UIImage {
            buttonToModify.setImage(originale, for: .normal)
            buttonToModify.imageView!.contentMode = .scaleAspectFill
            buttonToModify.imageView!.layer.masksToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

