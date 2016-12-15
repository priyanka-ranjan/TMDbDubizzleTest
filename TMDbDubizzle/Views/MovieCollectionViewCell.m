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
    
    
    NSString *imagePathString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@",movie.backdropPath];
    NSURL *imageURL = [NSURL URLWithString:imagePathString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            self.backgroundImage.image = image;
        });
    });
}

@end
