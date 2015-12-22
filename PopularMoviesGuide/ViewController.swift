//
//  ViewController.swift
//  PopularMoviesGuide
//
//  Created by Rakesh Kusuma on 22/12/15.
//  Copyright © 2015 Devsmugglers. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, MovieDataProtocol {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    let defaultsize = CGSizeMake(243,360)
    let focusSize = CGSizeMake(267.3,396)
    var moviesArray = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        MovieData.sharedInstance.movieDelegate = self
        MovieData.sharedInstance.downloadData()
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receivedResponseFromServer(response: AnyObject) {
        if let movArray = response as? [Movie] {
            moviesArray = movArray
        }
        collectionView.reloadData()
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell{
            let movie = moviesArray[indexPath.row]
            cell.configureCell(movie)
            
            if cell.gestureRecognizers?.count == nil {
                let tap = UITapGestureRecognizer(target: self, action: "movieTapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
            }
            
            
            return cell
        } else {
            return MovieCell()
        }
    
    }
    func movieTapped(gesture:UITapGestureRecognizer){
        if let cell = gesture.view as? MovieCell {
            // Load the Next View Controller and pass the Movie
            print("Tap Detected")
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(289, 474)
    }

    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                prev.movieImg.frame.size = self.defaultsize
            })
        }
        
        if let next = context.nextFocusedView as? MovieCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                next.movieImg.frame.size = self.focusSize
            })
        }
        
    }
    

}

