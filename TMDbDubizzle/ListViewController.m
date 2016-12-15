//
//  ViewController.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "ListViewController.h"

//Networking
#import "NetworkingManager.h"

//Models
#import "ListOfMoviesModel.h"
#import "MovieModel.h"

//Views
#import "MovieCollectionViewCell.h"

//View Controllers
#import "FilterViewController.h"
#import "MovieDetailsViewController.h"


@interface ListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, FilterViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *listCollectionView;
@property (nonatomic, strong) NSMutableArray *filteredListOfMovies;
@property (nonatomic, strong) NSString *titleText;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLabel;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.listTitleLabel.text = self.titleText;
}

#pragma mark - Setup

- (void)setupMovieListBasedOnMovieListType:(MovieListType)movieListType {
    __weak typeof(self) weakself = self;
    [NetworkingManager loadListOfMoviesBasedOnMovieListType:movieListType withCompletionHandler:^(ListOfMoviesModel *response) {
        weakself.filteredListOfMovies = [response.listOfMovies mutableCopy];
        [weakself.listCollectionView reloadData];
    }];
    
    [self addTitleBasedOnMovieListType:movieListType];
    
}

- (void)setupCollectionView {
    self.listCollectionView.delegate = self;
    self.listCollectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([MovieCollectionViewCell class]) bundle:[NSBundle mainBundle]];
    
    [self.listCollectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([MovieCollectionViewCell class])];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredListOfMovies.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MovieCollectionViewCell class])
                                                                              forIndexPath:indexPath];
    MovieModel *currentMovie = self.filteredListOfMovies[indexPath.row];
    [cell setupCellWithMovieModel:currentMovie];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, 150);
}


#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieModel *currentMovie = self.filteredListOfMovies[indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MovieDetailsViewController *movieDetailsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([MovieDetailsViewController class])];
    [movieDetailsViewController setupWithMovieModel:currentMovie];
    [self.navigationController pushViewController:movieDetailsViewController animated:YES];
    
    
}

#pragma mark - IBActions

- (IBAction)filterButtonTapped:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FilterViewController *filterViewController = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([FilterViewController class])];
    filterViewController.delegate = self;
    [self presentViewController:filterViewController animated:YES completion:nil];

}

#pragma mark - <FilterViewControllerProtocol>

- (void)filteredWithMinYear:(NSDate *)minDate maxYear:(NSDate *)maxDate {
    
    NSMutableArray *dateBasedFilteredListOfMovies = [NSMutableArray array];
    
    for (MovieModel *movie in self.filteredListOfMovies) {
        BOOL isAfterMinDate = [movie.releaseDate compare:minDate] == NSOrderedDescending;
        BOOL isBeforeMaxDate = [movie.releaseDate compare:maxDate] == NSOrderedAscending;
        if(isAfterMinDate && isBeforeMaxDate) {
            [dateBasedFilteredListOfMovies addObject:movie];
        }
    }
    
    self.filteredListOfMovies = dateBasedFilteredListOfMovies;
    [self.listCollectionView reloadData];
    
}

#pragma mark - Helpers

- (void)addTitleBasedOnMovieListType:(MovieListType)movieListType {
    
    switch (movieListType) {
        case MovieListTypePopular:
            self.titleText = @"Popular";
            break;
        case MovieListTypeTopRated:
            self.titleText = @"Top Rated";
            break;
        case MovieListTypeUpcoming:
            self.titleText = @"Upcoming";
            break;
        case MovieListTypeNowPlaying:
            self.titleText = @"Now Playing";
            break;
        default:
            break;
    }
    
}


@end
