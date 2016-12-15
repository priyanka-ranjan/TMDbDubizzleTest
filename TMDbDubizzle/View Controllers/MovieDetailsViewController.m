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

@interface MovieDetailsViewController ()

@property (nonatomic, strong) MovieModel *movieModel;

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieOverview;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *voteCount;
@property (weak, nonatomic) IBOutlet UIWebView *playerWebview;

@property (nonatomic, strong) ListOfMovieVideos *listOfMovieVideos;
@end

@implementation MovieDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViewBasedOnMovie];
}

#pragma mark - Setup

- (void)setupWithMovieModel:(MovieModel *)movieModel {
    self.movieModel = movieModel;
    
    __weak typeof(self) weakSelf = self;
    [NetworkingManager loadMovieVideosFromMovieId:[movieModel.movieId stringValue]
                            withCompletionHandler:^(ListOfMovieVideos *response) {
                                weakSelf.listOfMovieVideos = response;
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [weakSelf setupPlayerView];
                                });
                                

    }];
}

- (void)setupPlayerView {
    NSURL *youtubeURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/embed/%@",[self youtubeIdFromMovieVideos]]];
    self.playerWebview.allowsInlineMediaPlayback = YES;
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

@end
