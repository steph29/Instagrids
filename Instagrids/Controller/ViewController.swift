//
//  ViewController.swift
//  Instagrids
//
//  Created by stephane verardo on 03/01/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    // MARK - defined checkMarkButton action
    
    @IBAction func checkMarkLeft(_ sender: Any) {
        ItemsShowed(firstButton: checkMarkButtonLeft, firstImage: rectangleHigh, stackView: squareLowStackView)
        ItemsHidden(firstButton: checkMarkButtonMiddle, secondButton: checkMarkButtonRight, firstImage: rectangleLow, stackView: squareHighStackView)
    }
    
    @IBAction func checkMarkMiddle(_ sender: Any) {
        ItemsShowed(firstButton: checkMarkButtonMiddle, firstImage: rectangleLow, stackView: squareHighStackView)
        ItemsHidden(firstButton: checkMarkButtonLeft, secondButton: checkMarkButtonRight, firstImage: rectangleHigh, stackView: squareLowStackView)
    }
    
    @IBAction func checkMarkRight(_ sender: Any) {
        ItemsShowedStackViewOnly(firstButton: checkMarkButtonMiddle, firstStackView: squareHighStackView, secondStackView: squareLowStackView)
        ItemsHiddenStackViewOnly(firstButton: checkMarkButtonLeft, secondButton: checkMarkButtonMiddle, firstImage: rectangleLow, secondImage: rectangleHigh)
    }
    
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
    }
    
    // MARK -
    
}
