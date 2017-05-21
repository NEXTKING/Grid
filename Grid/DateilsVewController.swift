//
//  DateilsVewController.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

class DateilsVewController: UIViewController {

    public var profile: Profile!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = profile.image
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFacorites(sender: UIButton) {
        
        if let favorites = UserDefaults.standard.object(forKey: "Favorites") as? Array<Int> {
            
            var set = Set(favorites)
            set.insert(profile.id)
            UserDefaults.standard.set(Array(set), forKey: "Favorites")
        }
        else {
            UserDefaults.standard.set([profile.id], forKey: "Favorites")
        }
        
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("FavoritesNotification"), object: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
