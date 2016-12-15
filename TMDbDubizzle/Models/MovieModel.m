//
//  MovieModel.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//


/*
 {
 adult = 0;
 "backdrop_path" = "/dkMD5qlogeRMiEixC4YNPUvax2T.jpg";
 "genre_ids" =             (
 28,
 12,
 878,
 53
 );
 id = 135397;
 "original_language" = en;
 "original_title" = "Jurassic World";
 overview = "Twenty-two years after the events of Jurassic Park, Isla Nublar now features a fully functioning dinosaur theme park, Jurassic World, as originally envisioned by John Hammond.";
 popularity = "13.268487";
 "poster_path" = "/jjBgi2r5cRt36xF6iNUEhzscEcb.jpg";
 "release_date" = "2015-06-09";
 title = "Jurassic World";
 video = 0;
 "vote_average" = "6.5";
 "vote_count" = 5417;
 }
 */
#import "MovieModel.h"

@interface MovieModel ()


@end

@implementation MovieModel

+ (NSDictionary<NSString *, NSString *> *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieId" : @"id",
             @"title" : @"original_title",
             @"backdropPath":  @"backdrop_path" ,
             @"posterPath" : @"poster_path" ,
             @"overview" : @"overview",
             @"voteAverage" : @"vote_average",
             @"voteCount" :  @"vote_count" ,
             @"releaseDate" : @"release_date" ,
             };
}

+ (NSValueTransformer *)releaseDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-mm-dd"];
        return [dateFormatter dateFromString:dateString];
    }];
}

@end
