//
//  ProfilesServiceNetwork.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

class ProfilesServiceNetwork: ProfileServiceInterface {

    
    private let serviceURL = "https://fierce-harbor-90458.herokuapp.com"

    public func profiles(_ onComplete: @escaping ([Profile]) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: serviceURL + "/profiles") else {
            onError("Cannot create url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                onError(error?.localizedDescription ?? "Error loading profiles")
                return
            }
            guard let data = data else {
                onError(error?.localizedDescription ?? "No data")
                return
            }
            
            if let profiles = ProfileServiceJSONSerializer.profiles(data) {
                onComplete(profiles)
            } else {
                onError("Error parsing JSON")
            }
        }
        
        task.resume()
    }
    public func detailedPrifile(_ withId: String, onComplete: @escaping (Profile) -> Void, onError: @escaping (String) -> Void) {
    }
    
    public func profileImage(_ withUrl: String, onComplete: @escaping (UIImage) -> Void, onError: @escaping (String) -> Void) {
        
        guard let url = URL(string: withUrl) else {
            onError("Cannot create url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                onError(error?.localizedDescription ?? "Error loading image")
                return
            }
            guard let data = data else {
                onError(error?.localizedDescription ?? "No data")
                return
            }
            
            if let image  = UIImage(data: data) {
                onComplete(image)
            } else {
                onError("Error parsing JSON")
            }
        }
        
        task.resume()
        
    }
    
    
}
