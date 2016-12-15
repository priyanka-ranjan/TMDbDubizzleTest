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

@interface ListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *listCollectionView;
@property (nonatomic, strong) ListOfMoviesModel *listModel;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];

    __weak typeof(self) weakself = self;
    [NetworkingManager loadInitialListOfPopularMoviesWithCompletionHandler:^(ListOfMoviesModel *response) {
        weakself.listModel = response;
        [weakself.listCollectionView reloadData];
    }];
}

#pragma mark - Setup

- (void)setupCollectionView {
    self.listCollectionView.delegate = self;
    self.listCollectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([MovieCollectionViewCell class]) bundle:[NSBundle mainBundle]];
    
    [self.listCollectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([MovieCollectionViewCell class])];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listModel.listOfMovies.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MovieCollectionViewCell class])
                                                                              forIndexPath:indexPath];
    MovieModel *currentMovie = self.listModel.listOfMovies[indexPath.row];
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
    
}

@end
