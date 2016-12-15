//
//  ViewController.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetworkingManager.h"

@interface ListViewController : UIViewController

@property (nonatomic, assign) NSInteger pageIndex;
- (void)setupMovieListBasedOnMovieListType:(MovieListType)movieListType;

@end

