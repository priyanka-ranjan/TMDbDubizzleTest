//
//  MovieDetailsViewController.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "MovieDetailsViewController.h"


//Networking
#import "NetworkingManager.h"

@interface MovieDetailsViewController () <UIWebViewDelegate>

@property (nonatomic, strong) MovieModel *movieModel;
@property (nonatomic, strong) ListOfMovieVideos *listOfMovieVideos;

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UITextView *movieOverview;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *voteCount;
@property (weak, nonatomic) IBOutlet UIWebView *playerWebview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewBasedOnMovie];
    self.playerWebview.delegate = self;
    [self.activityIndicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    [NetworkingManager loadMovieVideosFromMovieId:[self.movieModel.movieId stringValue]
                            withCompletionHandler:^(ListOfMovieVideos *response) {
                                weakSelf.listOfMovieVideos = response;
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [weakSelf setupPlayerView];
                                });
                            }];
}

#pragma mark - Setup

- (void)setupWithMovieModel:(MovieModel *)movieModel {
    self.movieModel = movieModel;
}

- (void)setupPlayerView {
    NSURL *youtubeURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/embed/%@",[self youtubeIdFromMovieVideos]]];
    [self.playerWebview loadRequest:[NSURLRequest requestWithURL:youtubeURL]];
}

- (void)setupViewBasedOnMovie {
    self.movieTitle.text = self.movieModel.title;
    self.movieOverview.text = self.movieModel.overview;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-mm-dd";
    self.releaseDate.text = [dateFormatter stringFromDate:self.movieModel.releaseDate];
    self.voteCount.text = [NSString stringWithFormat:@"Vote Count: %@",[self.movieModel.voteCount stringValue]];
    
}

- (NSString *)youtubeIdFromMovieVideos {
    for (MovieVideoModel *movieVideo in self.listOfMovieVideos.videos) {
        if ([movieVideo.site isEqualToString:@"YouTube"]) {
            return movieVideo.youtubeId;
        }
    }
    return nil;
}

#pragma mark - <UIWebviewDelegate >

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

@end
