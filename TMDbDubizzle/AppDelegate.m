//
//  AppDelegate.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle:[NSBundle mainBundle]];
    UINavigationController *mainNavigatationController = [mainStoryboard instantiateInitialViewController];
    self.window.rootViewController = mainNavigatationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
