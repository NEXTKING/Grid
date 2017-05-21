//
//  GridViewController.swift
//  Grid
//
//  Created by Denis Kurochkin on 21/05/2017.
//  Copyright © 2017 Denis Kurochkin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

class GridViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var selectedIndexPath: IndexPath!
    private var profiles: [Profile] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(GridViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("FavoritesNotification"), object: nil)
        
        ServiceDispatcher.sharedInstance.profilesService .profiles({  profiles -> Void in
            self.profiles = profiles
            
        }, onError: {  error -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let profile = profiles[selectedIndexPath.row]
        let destinationVC = segue.destination as! DateilsVewController
        destinationVC.profile = profile
        
        
        
       // destinationVC.imageView.image = profile.image
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.profiles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
    
        // Configure the cell
        
        let profile = profiles[indexPath.row]
        cell.imageView.image = profile.image
        cell.setImageState(state: profile.imageState)
        cell.favoritesImage.isHidden = !checkIfFavorite(profile: profile)
        
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let profile = profiles[indexPath.row]
        let cell = cell as! ProfileCollectionViewCell
        
        if profile.imageState == .notLoaded {
            
            guard let url = profile.pictureUrl else {
                profile.imageState = .noImage
                return
            }
            
            profile.imageState = .isLoading
            cell.setImageState(state: .isLoading)
            
            ServiceDispatcher.sharedInstance.profilesService.profileImage(url, onComplete: {  image -> Void in
                
                profile.image = image
                profile.imageState = .loaded
                
                if (self.collectionView?.indexPathsForVisibleItems .contains(indexPath))! {
                    DispatchQueue.main.async {
                        cell.imageView.image = image;
                        cell.setImageState(state: .loaded)
                    }
                }
                
            }, onError: { error -> Void in
                
            })
        }
    }
    
    

    // MARK: UICollectionViewDelegate\
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedIndexPath = indexPath
        return true
    }
    
    
    // MARK: FlowLayoutDelegate
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let cellWidth = screenWidth / 2.0 - 30;
        
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
    // MARK: Internal
    
    private func checkIfFavorite(profile: Profile) -> Bool {
        if let array = UserDefaults.standard.object(forKey: "Favorites") as? Array<Int>{
            let set = Set(array)
            return set.contains(profile.id)
            
        } else {
            return false
        }
        
    }
    
    func methodOfReceivedNotification(notification: Notification){
        self.collectionView?.reloadData()
    }
    

}
