//
//  ViewController.swift
//  Instagrids
//
//  Created by stephane verardo on 03/01/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var squareLowRight: UIImageView!
    @IBOutlet weak var squareLowLeft: UIImageView!
    @IBOutlet weak var rectangleHigh: UIImageView!
    @IBOutlet weak var rectangleLow: UIImageView!
    @IBOutlet weak var squareHighRight: UIImageView!
    @IBOutlet weak var squareHighLeft: UIImageView!
    @IBOutlet weak var checkMarkButtonLeft: UIButton!
    @IBOutlet weak var checkMarkButtonMiddle: UIButton!
    @IBOutlet weak var checkMarkButtonRight: UIButton!
    

 
    @IBAction func checkmarkLeft(_ sender: Any) {
        ItemsHidden(button: checkMarkButtonMiddle, secondButton: checkMarkButtonRight, firstImage: squareHighRight, secondImage: squareHighLeft, thirdImage: rectangleLow)
       
    }
    
    private func ItemsHidden(button: UIButton, secondButton: UIButton, firstImage: UIImageView, secondImage: UIImageView, thirdImage: UIImageView){
        button.imageView?.isHidden = true
        secondButton.imageView?.isHidden = true
        firstImage.isHidden = true
        secondImage.isHidden = true
        thirdImage.isOpaque = true
    }
    
    private func RectangleHidden(rectangle: UIImageView){
        rectangle.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 143, trailing: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        }
            }
