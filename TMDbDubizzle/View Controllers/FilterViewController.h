//
//  FilterViewController.h
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewControllerProtocol <NSObject>
- (void)filteredWithMinYear:(NSDate *)minYear maxYear:(NSDate *)maxYear;
@end

@interface FilterViewController : UIViewController

@property (nonatomic, weak) id<FilterViewControllerProtocol> delegate;

@end
