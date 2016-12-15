//
//  NetworkingManager.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "NetworkingManager.h"

//Keys
#define kTMDBApiKey @"c050955eab1508f4a25330fa32f3be14"

//Base URLS
#define kBaseURLMovie @"https://api.themoviedb.org/3/movie"

@implementation NetworkingManager

+ (void)loadInitialListOfPopularMoviesWithCompletionHandler:(void (^)(ListOfMoviesModel *respose))completion {
    NSString *baseUrlString = [NSString stringWithFormat:@"%@/popular?api_key=%@&language=en-US&page=1",kBaseURLMovie,kTMDBApiKey];
    NSURL *baseURL = [NSURL URLWithString:baseUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *jsonError;
        
        if (data) {
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            if (jsonError) {
                NSLog(@"---- The error is %@", jsonError);
            } else {
                
                NSError *mtlError;
                
                ListOfMoviesModel *listOfMovies = [MTLJSONAdapter modelOfClass:ListOfMoviesModel.class
                                                            fromJSONDictionary:jsonData
                                                                         error:&mtlError];
                
                if (!mtlError) {
                    completion(listOfMovies);
                } else {
                    NSLog(@"---- The error is %@", mtlError);

                }
                
                
//                NSLog(@"---- The parsed data is: %@", jsonData);
            }
            
        }
        
    }];
    [task resume];
}

@end
