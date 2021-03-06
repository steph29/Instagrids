//
//  ViewController.swift
//  Instagrids
//
//  Created by stephane verardo on 03/01/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit
import AVFoundation

// Controller
class ViewController: UIViewController {
    
    @IBOutlet weak var labelSwipeView: UIStackView! // Outlet of The Label "Swpie up to share"
    @IBOutlet weak var viewSwiped: UIView! // Outlet of the deep blue view with imageView
    // Outlet concerning Button
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    // outlet of button of selection
    @IBOutlet weak var checkMarkButtonLeft: UIButton!
    @IBOutlet weak var checkMarkButtonMiddle: UIButton!
    @IBOutlet weak var checkMarkButtonRight: UIButton!

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
   
    func upDateSelectedButton(firstButtonState: Bool, secondButtonState: Bool, thridButtonState: Bool) {
        checkMarkIsSelectedLeft = firstButtonState
        checkMarkIsSelectedMiddle = secondButtonState
        checkMarkIsSelectedRight = thridButtonState
    }
  
     // function for the checkMark Button
    @IBAction func checkMark(_ sender: Any) {
        let buttonUsed = sender as! UIButton
        print(buttonUsed.tag)
        switch buttonUsed.tag {
        case 11:
           upDateSelectedButton(firstButtonState: true, secondButtonState: false, thridButtonState: false)
            ItemsShowed(firstButton: checkMarkButtonLeft, firstImage: button3, thirdButton: button4)
            ItemsHidden(firstButton: checkMarkButtonMiddle, secondButton: checkMarkButtonRight, thirdButton: button2)
        case 12:
            upDateSelectedButton(firstButtonState: false, secondButtonState: true, thridButtonState: false)
            ItemsShowed(firstButton: checkMarkButtonMiddle, firstImage: button1, thirdButton: button2)
            ItemsHidden(firstButton: checkMarkButtonLeft, secondButton: checkMarkButtonRight, thirdButton: button4)
        case 13:
           upDateSelectedButton(firstButtonState: false, secondButtonState: false, thridButtonState: true)
            checkMarkButtonLeft.imageView?.isHidden = true
            checkMarkButtonMiddle.imageView?.isHidden = true
            button4.isHidden = false
            button3.isHidden = false
            button1.isHidden = false
            button2.isHidden = false
        default:
            break
        }
        
    }
    
    // Mark - function to change the layout of the images
    private func ItemsShowed(firstButton: UIButton,  firstImage: UIView, thirdButton: UIButton){
        firstButton.imageView?.isHidden = false
        firstImage.isHidden = false
        thirdButton.isHidden = false
    }
    
    private func ItemsHidden(firstButton: UIButton, secondButton: UIButton,  thirdButton: UIButton){
        firstButton.imageView?.isHidden = true
        secondButton.imageView?.isHidden = true
        thirdButton.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMark(checkMarkButtonLeft)
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        UIView.animate(withDuration: 0.5) {
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
    // function about the gesture in landscape or portrait orientation
    func gestureAnimation(gestureRecognizer: UIGestureRecognizer) {
        viewSwiped.gestureRecognizers?.forEach(viewSwiped.removeGestureRecognizer)
        viewSwiped.addGestureRecognizer(gestureRecognizer)
        viewSwiped.transform = .identity
    }
    
    override func viewWillLayoutSubviews() {
        if UIDevice.current.orientation.isPortrait{
            let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            upSwipe.direction = .up
           gestureAnimation(gestureRecognizer: upSwipe)
        }else{
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            leftSwipe.direction = .left
            gestureAnimation(gestureRecognizer: leftSwipe)
        }
        
    }
    
    // Swipe animation
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer){
        if (!IsLoaded()){
            alertIsNotLoaded()
        }else {
            if UIDevice.current.orientation.isPortrait {
                swipeAnimation(translationX: 0, y: -view.bounds.height)
                
            } else if UIDevice.current.orientation.isLandscape{
                swipeAnimation(translationX: -view.bounds.width, y: 0)
            }
            handleShare()
        }
        
        
    }
    
    // function creating the animation
    func swipeAnimation(translationX x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.viewSwiped.transform = CGAffineTransform(translationX: x, y: y)
        }, completion: nil)
    }
    
    
    // Alert if not all image are loaded
    func alertIsNotLoaded() {
        let alert = UIAlertController(title: "Pas si vite!", message: "Toutes les photos ne sont pas chargées", preferredStyle: .alert)
        let annuler = UIAlertAction(title: "Je comprends", style: .destructive, handler: nil)
        alert.addAction(annuler)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // function to share the content
    func handleShare() {
        UIGraphicsBeginImageContext(viewSwiped.bounds.size)
        viewSwiped.layer.render(in: UIGraphicsGetCurrentContext()!) // Return the current graphics context
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            self.viewSwiped.transform = .identity
        }
        
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
    @IBAction func prendrePhoto(_ sender: Any) {
        capturePicture()
        lastTagButtonSelected = (sender as AnyObject).tag
        IsImageLoaded(tag: lastTagButtonSelected)
    }
    
    func IsImageLoaded(tag: Int) {
        if tag == 1{
            imageLoaded1 = true
        }else if tag == 2{
            imageLoaded2 = true
        }else if tag == 3{
            imageLoaded3 = true
        }else if tag == 4{
            imageLoaded4 = true
        }
    }
    
    // MARK - Connection to the camera or library
    func presentWithSource(_ source: UIImagePickerController.SourceType)  {
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func capturePicture() {
        let alerteActionSheet = UIAlertController(title: "Prendre une photo", message: "Choisissez le média", preferredStyle: .actionSheet)
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

// Extension to upload image from library or from camera and adjust the size
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let buttonToModify = self.view.viewWithTag(lastTagButtonSelected) as! UIButton
        if let edite = info[.editedImage] as? UIImage {
            buttonToModify.setImage(edite, for: .normal)     
        } else if let originale = info[.originalImage] as? UIImage {
            buttonToModify.setImage(originale, for: .normal)
        }
        buttonToModify.imageView!.contentMode = .scaleAspectFill
        buttonToModify.imageView!.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

