//
//  MovieModel.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MovieModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *backdropPath;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSNumber *voteAverage;
@property (nonatomic, strong) NSNumber *voteCount;
@property (nonatomic, strong) NSString *releaseDate;


@end
