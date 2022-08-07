//
//  KidsCollectionViewCell.swift
//  DaycareCalc
//
//  Created by Daniel Gonzalez on 8/6/22.
//

import UIKit

class KidsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kidsNameLabel: UILabel!
    static let identifier = "KidsCollectionViewCell"

    public func configure(with image: UIImage, name: String) {
        imageView.image = image
        kidsNameLabel.text = name
    }

}
