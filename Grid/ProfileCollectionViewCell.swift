//
//  ProfileCollectionViewCell.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var favoritesImage: UIImageView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setImageState(state: ImageState) {
        
        if state == .isLoading {
            loadingActivity.startAnimating()
        } else {
            loadingActivity.stopAnimating()
        }
        
        
    }
}
