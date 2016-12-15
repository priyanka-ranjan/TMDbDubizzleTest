//
//  ListOfMoviesModel.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "ListOfMoviesModel.h"

@implementation ListOfMoviesModel
+ (NSDictionary<NSString *, NSString *> *)JSONKeyPathsByPropertyKey {
    return @{
             @"pageNumber" : @"page",
             @"listOfMovies" : @"results",
             };
}

+ (NSValueTransformer *)listOfMoviesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MovieModel.class];
}

@end
