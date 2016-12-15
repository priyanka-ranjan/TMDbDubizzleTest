//
//  NetworkingManager.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <Foundation/Foundation.h>

//Models
#import "ListOfMoviesModel.h"
#import "MovieModel.h"
#import "ListOfMovieVideos.h"
#import "MovieVideoModel.h"

typedef NS_ENUM(NSUInteger, MovieListType) {
    MovieListTypePopular,
    MovieListTypeTopRated,
    MovieListTypeUpcoming,
    MovieListTypeNowPlaying
};

@interface NetworkingManager : NSObject

+ (void)loadListOfMoviesBasedOnMovieListType:(MovieListType)movieListType
                       withCompletionHandler:(void (^)(ListOfMoviesModel *respose))completion;
+ (void)loadMovieVideosFromMovieId:(NSString *)movieID
             withCompletionHandler:(void(^)(ListOfMovieVideos *response))completion;


@end
