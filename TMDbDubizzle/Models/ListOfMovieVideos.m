//
//  ListOfMovieVideos.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "ListOfMovieVideos.h"

@implementation ListOfMovieVideos

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieId" : @"id",
             @"videos" : @"results"
             };
}

+ (NSValueTransformer *)videosJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MovieVideoModel.class];
}

@end
