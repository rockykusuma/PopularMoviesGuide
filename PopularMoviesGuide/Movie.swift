//
//  Movie.swift
//  PopularMoviesGuide
//
//  Created by Rakesh Kusuma on 22/12/15.
//  Copyright © 2015 Devsmugglers. All rights reserved.
//

import Foundation

class Movie {
    var title : String!
    var overview : String!
    var posterPath : String!
    
    init(movieDict : Dictionary <String , AnyObject>){
        
        if let title = movieDict["title"] as? String {
            self.title = title
        }
        if let overview = movieDict["overview"] as? String {
            self.overview = overview
        }
        if let posterPath = movieDict["poster_path"] as? String {
            self.posterPath = "\(POSTER_BASEURL)\(posterPath)"
            //print(self.posterPath)
        }
    }

    
}