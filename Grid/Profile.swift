//
//  Profile.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

public enum ImageState {
    case notLoaded
    case isLoading
    case loaded
    case noImage
}

public class Profile {

    public var id: Int!
    public var pictureUrl: String?
    
    //Detailed
    
    public var firstName: String?
    public var lastName: String?
    
    // This should have been not in MODEL but in VIEWMODEl but no time for that =(
    
    public var imageState: ImageState = .notLoaded
    public var image: UIImage?
}
