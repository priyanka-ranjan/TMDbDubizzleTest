//
//  ListOfMoviesModel.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "MovieModel.h"

@interface ListOfMoviesModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *pageNumber;
@property (nonatomic, strong) NSArray <MovieModel *> *listOfMovies;

@end
