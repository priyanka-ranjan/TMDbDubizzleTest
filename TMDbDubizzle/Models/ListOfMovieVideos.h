//
//  ListOfMovieVideos.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <Mantle/Mantle.h>

//Models
#import "MovieVideoModel.h"

@interface ListOfMovieVideos : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *movieId;
@property (nonatomic, strong) NSArray <MovieVideoModel *> *videos;

@end
