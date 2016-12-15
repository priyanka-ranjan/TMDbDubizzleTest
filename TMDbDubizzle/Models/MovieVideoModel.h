//
//  MovieVideoModel.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MovieVideoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *youtubeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *site;

@end
