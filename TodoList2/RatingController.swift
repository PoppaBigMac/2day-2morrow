//
//  RatingController.swift
//  FoodTracker
//
//  Created by Cesar Martinez on 11/3/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit

class RatingController: UIView {
    // MARK: Properties
    var rating: Int = 0 {
        // Property Observer
        didSet {
            // Triggers layout update when rating changes
            setNeedsLayout()
        }
    }
    var ratingButtons: [UIButton] = [UIButton]()
    let spacing: Int = 5
    let starCount: Int = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
            // No need to set the boundaries because they are set in layoutSubviews
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(filledStar, for: [.highlighted, .selected])
            // Since we have images, we do not need to be shown that a button is highlighted
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RatingController.ratingButtonTapped(button:)), for: .touchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        // .enumerated() returns a tuple with the index of the item and then the item, in this
        // case it is a button
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        // Set the right images for each star button
        updateButtonSelectionStates()
    }
    
    override var intrinsicContentSize: CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Actions
    
    func ratingButtonTapped(button: UIButton) {
        // Since we know the buttons are all in the ratingButtons array it is okay to force unwrap
        rating = ratingButtons.index(of: button)! + 1
        
        // Set the right images for each star button
        updateButtonSelectionStates()
    }
    
    // MARK: Helper Methods
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // this checks if the index is less than the rating, it gives a Bool to .isSelected
            button.isSelected = index < rating
        }
    }
}
