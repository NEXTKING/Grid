//
//  ProfilesServiceProtocol.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

public protocol ProfileServiceInterface {
    
    func profiles(_ onComplete: @escaping ([Profile]) -> Void, onError: @escaping (String) -> Void)
    func detailedPrifile(_ withId: String, onComplete: @escaping (Profile) -> Void, onError: @escaping (String) -> Void)
    func profileImage(_ withUrl: String, onComplete: @escaping (UIImage) -> Void, onError: @escaping (String) -> Void)
}
