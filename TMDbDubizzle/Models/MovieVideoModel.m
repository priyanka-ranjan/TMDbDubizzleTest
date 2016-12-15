//
//  MovieVideoModel.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "MovieVideoModel.h"

@implementation MovieVideoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"videoId" : @"id",
             @"youtubeId" : @"key",
             @"title" : @"title",
             @"site" : @"site"
             };
}
@end
