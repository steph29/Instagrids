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
    

 
    @IBAction func checkmarkLeft(_ sender: Any) {
        ItemsHidden(firstButton: checkMarkButtonMiddle, secondButton: checkMarkButtonRight, firstImage: squareHighRight, secondImage: squareHighLeft, thirdImage: rectangleLow)
       
    }
    
    private func ItemsHidden(firstButton: UIButton, secondButton: UIButton, firstImage: UIView, secondImage: UIView, thirdImage: UIView){
        firstButton.imageView?.isHidden = true
        secondButton.imageView?.isHidden = true
        firstImage.isHidden = true
        secondImage.isHidden = true
        thirdImage.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
            }
