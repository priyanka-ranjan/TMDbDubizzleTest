//
//  MovieCollectionViewCell.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "MovieCollectionViewCell.h"

#import "UIImageView+AFNetworking.h"

@interface MovieCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *voteAverage;
@end

@implementation MovieCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 12.0;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.movieTitle.text = nil;
    self.backgroundImage.image = nil;
    self.releaseDate.text = nil;
    self.voteAverage.text = nil;
}

- (void)setupCellWithMovieModel:(MovieModel *)movie {
    self.movieTitle.text = movie.title;
    self.releaseDate.text = [NSString stringWithFormat:@"Release Date: %@",[self configureReleaseDateLabelWithDate:movie.releaseDate]];
    self.voteAverage.text = [NSString stringWithFormat:@"Vote Avg: %@", [movie.voteAverage stringValue]];
    [self configureMovieImageWithPath:movie.backdropPath];
}

- (NSString *)configureReleaseDateLabelWithDate:(NSDate *)releaseDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-mm-dd";
    return [dateFormatter stringFromDate:releaseDate];
}

- (void)configureMovieImageWithPath:(NSString *)backdropPath {
    NSString *imagePathString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@",backdropPath];
    NSURL *imageURL = [NSURL URLWithString:imagePathString];
    [self.backgroundImage setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
}


@end
