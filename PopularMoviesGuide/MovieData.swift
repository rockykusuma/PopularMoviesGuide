//
//  MovieData.swift
//  PopularMoviesGuide
//
//  Created by Rakesh Kusuma on 22/12/15.
//  Copyright © 2015 Devsmugglers. All rights reserved.
//

import Foundation

protocol MovieDataProtocol {
    func receivedResponseFromServer(response: AnyObject)
}

class MovieData {
    
//    class var sharedInstance: MovieData {
//        struct Static {
//            static let instance: MovieData = MovieData()
//        }
//        return Static.instance
//    }
//    
    static let sharedInstance = MovieData()
    var movieDelegate: MovieDataProtocol!
    
    var movies = [Movie]()
    
    func downloadData(){
        
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
                            
                            
                            for obj in results {
                                let movie = Movie(movieDict:obj)
                                self.movies.append(movie)
                            }
                            self.movieDelegate.receivedResponseFromServer(self.movies)
                           
                            
                        }
                    } catch {
                        
                    }
            }
        }
        task.resume()
    }
    

}