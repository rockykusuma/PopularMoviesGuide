//
//  ViewController.swift
//  PopularMoviesGuide
//
//  Created by Rakesh Kusuma on 22/12/15.
//  Copyright © 2015 Devsmugglers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView : UICollectionView!
    var movieData : MovieData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieData.downloadData()
        //downloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadData(){
        
        let POPULARMOVIES_URL = "\(URL_POPULAR)\(API_KEY)"
        
        let url = NSURL(string: POPULARMOVIES_URL)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (NSData, NSURLResponse, NSError) -> Void in
            if NSError != nil {
                print(NSError.debugDescription)
            } else {
                do {
                    
                    let dict = try NSJSONSerialization.JSONObjectWithData(NSData!, options: .AllowFragments) as? Dictionary <String , AnyObject>
                    
                    
                    if let results = dict!["results"] as? [Dictionary<String , AnyObject>] {
                        print(results)
                        
                    }
                } catch {
                    
                }
                
            }
        }
        task.resume()
        
        
    }

    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(380, 601)
    }

    

}

