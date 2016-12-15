//
//  MovieDetailsViewController.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

//Models
#import "MovieModel.h"

@interface MovieDetailsViewController : UIViewController

- (void)setupWithMovieModel:(MovieModel *)movieModel;

@end
