//
//  MovieDetailsViewController.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "MovieDetailsViewController.h"


@interface MovieDetailsViewController ()

@property (nonatomic, strong) MovieModel *movieModel;

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieOverview;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *voteCount;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupViewBasedOnMovie];
}

#pragma mark - Setup

- (void)setupWithMovieModel:(MovieModel *)movieModel {
    self.movieModel = movieModel;
}

- (void)setupViewBasedOnMovie {
    NSString *imagePathString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@",self.movieModel.posterPath];
    NSURL *imageURL = [NSURL URLWithString:imagePathString];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.posterImage.image= [UIImage imageWithData:imageData];
        });
    });
    
    
    self.movieTitle.text = self.movieModel.title;
    self.movieOverview.text = self.movieModel.overview;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-mm-dd";
    self.releaseDate.text = [dateFormatter stringFromDate:self.movieModel.releaseDate];
    self.voteCount.text = [NSString stringWithFormat:@"Vote Count: %@",[self.movieModel.voteCount stringValue]];
    
}

@end
