//
//  ProfileServiceJSONSerializer.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

class ProfileServiceJSONSerializer {
    
    static func profiles(_ data: Data) -> [Profile]? {
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<AnyHashable, Any>] else {
            return nil
        }
        
        var profiles = [Profile]()
        
        for profile in json! {
            
            let profileObj = Profile()
            profileObj.id           = profile["id"] as? Int ?? -1
            profileObj.pictureUrl   = profile["profile_picture"] as? String ?? ""
            profiles.append(profileObj)
            
        }
       
        
        
        return profiles
    }
    
}
