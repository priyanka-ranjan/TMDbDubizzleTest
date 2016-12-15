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

@interface NetworkingManager : NSObject

+ (void)loadInitialListOfPopularMoviesWithCompletionHandler:(void(^)(ListOfMoviesModel* response))completion;

@end
