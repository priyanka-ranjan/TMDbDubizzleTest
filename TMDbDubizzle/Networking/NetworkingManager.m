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

+ (void)loadListOfMoviesBasedOnMovieListType:(MovieListType)movieListType withCompletionHandler:(void (^)(ListOfMoviesModel *respose))completion {
    NSString *baseUrlString = [self baseUrlBasedOnMovieListType:movieListType];
    NSURL *baseURL = [NSURL URLWithString:baseUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *jsonError;
        if (data) {
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&jsonError];
            
            if (jsonData) {
                
                NSError *mtlError;
                ListOfMoviesModel *listOfMovies = [MTLJSONAdapter modelOfClass:ListOfMoviesModel.class
                                                            fromJSONDictionary:jsonData
                                                                         error:&mtlError];
                if (!mtlError) {
                    completion(listOfMovies);
                }
            }
        }
    }];
    [task resume];
}

+ (void)loadMovieVideosFromMovieId:(NSString *)movieID withCompletionHandler:(void(^)(ListOfMovieVideos *response))completion{
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@/videos?api_key=%@&language=en-US",kBaseURLMovie, movieID, kTMDBApiKey];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseUrl]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                NSError *jsonError;
                                                
                                                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                         options:NSJSONReadingMutableContainers
                                                                                                           error:&jsonError];
                                                
                                                if (jsonData) {
                                                    NSError *mtlError;
                                                    
                                                    ListOfMovieVideos *videos = [MTLJSONAdapter modelOfClass:ListOfMovieVideos.class
                                                                                          fromJSONDictionary:jsonData
                                                                                                       error:&mtlError];
                                                    
                                                    if (!mtlError) {
                                                        completion(videos);
                                                    }
                                                }
                                                
                                                
                                            }];
    [task resume];
}

#pragma mark - Helpers

+ (NSString *)baseUrlBasedOnMovieListType:(MovieListType)movieListType {
    NSString *movieListTypeKeyword;

    switch (movieListType) {
        case MovieListTypePopular:
            movieListTypeKeyword = @"popular";
            break;
        case MovieListTypeTopRated:
            movieListTypeKeyword = @"top_rated";
            break;
        case MovieListTypeUpcoming:
            movieListTypeKeyword = @"upcoming";
            break;
        case MovieListTypeNowPlaying:
            movieListTypeKeyword = @"now_playing";
            break;
        default:
            break;
    }

    return  [NSString stringWithFormat:@"%@/%@?api_key=%@&language=en-US&page=1",kBaseURLMovie,movieListTypeKeyword, kTMDBApiKey];
}

@end
