//
//  ViewController.swift
//  CATransitionDemo
//
//  Created by Jake Chasan on 6/1/16.
//  Copyright © 2016 Jake Chasan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Class Variables
    private let transitions: [CATransitionType] = [.fade, .moveIn, .push, .reveal]
    private let directions: [CATransitionSubtype] = [.fromLeft, .fromRight, .fromTop, .fromBottom]
    private let durations = [0.0, 0.15, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0]
    private let easing: [CAMediaTimingFunctionName] = [.linear, .easeIn, .easeOut, .easeInEaseOut]
    private let images = ["imageA.jpg", "imageB.jpg"].compactMap(UIImage.init(named:))
    private var currentImage = 0
    @IBOutlet var transitionPicker: UIPickerView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        imageView.image = images[currentImage]
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(transitions.count / 2, inComponent: 0, animated: false)
        pickerView.selectRow(1, inComponent: 1, animated: false)
        pickerView.selectRow(2, inComponent: 2, animated: false)
        pickerView.selectRow(2, inComponent: 3, animated: false)
    }
    
    private func runAnimation(view: UIView) {
        let animation = CATransition()
        animation.type = transitions[pickerView.selectedRow(inComponent: 0)]
        animation.subtype = directions[pickerView.selectedRow(inComponent: 1)]
        animation.duration = durations[pickerView.selectedRow(inComponent: 2)]
        animation.timingFunction = CAMediaTimingFunction(name: easing[pickerView.selectedRow(inComponent: 3)])
        view.layer.add(animation, forKey: "fade-animation")
    }
    
    //Called when "View Transition" button tapped
    @IBAction func showTransition() {
        currentImage = (currentImage + 1) % images.count
        imageView.image = images[currentImage]
        runAnimation(view: imageView)
        
//        self.imageView.layer.add(animation, forKey: "animation")
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    //UIPickerView DataSource method
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Determine how many rows in each column
        switch(component){
        case 0:return transitions.count
        case 1: return directions.count
        case 2: return durations.count
        case 3: return easing.count
        default: return 0
        }
    }
    
    //UIPickerView DataSource method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Determine the title of each row in each column
        switch(component){
        case 0: return transitions[row].rawValue
        case 1: return directions[row].rawValue.lowercased().components(separatedBy: "from").joined()
        case 2: return "\(durations[row])s"
        case 3: return easing[row].rawValue.lowercased().components(separatedBy: "ease").joined(separator: " ")
        default: return ""
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    //This method is only necessary because the cameraIris transition sometimes does not go away after the animation is complete
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
