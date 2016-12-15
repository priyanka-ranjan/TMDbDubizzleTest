//
//  MovieCollectionViewCell.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "MovieCollectionViewCell.h"

@interface MovieCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@end

@implementation MovieCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.movieTitle.textColor = [UIColor blackColor];
}

- (void)setupCellWithMovieModel:(MovieModel *)movie {
    self.movieTitle.text = movie.title;
}

@end
