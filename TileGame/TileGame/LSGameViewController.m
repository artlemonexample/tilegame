//
//  LSGameViewController.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/28/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSGameViewController.h"

#import "LSTileCollectionViewCell.h"
#import "LSTile.h"

CGFloat const kOffset = 15.0;

@interface LSGameViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSIndexPath *firstOpenTile;
@property (nonatomic, strong) NSIndexPath *secondOpenTile;
@property (nonatomic, assign) BOOL blockManualFlipping;

@end

@implementation LSGameViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.currentGame.startDate == nil) {
        self.currentGame.startDate = [NSDate date];
    }
    [self updateTitle];
    [self.collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentGame.itemsInLine * self.currentGame.itemsInColumns;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LSTileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tile_cell" forIndexPath:indexPath];
    [cell updateWithModel:self.currentGame.tilesSet[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.blockManualFlipping) {
        return;
    }
    // Logic of flip
    LSTile *tile = self.currentGame.tilesSet[indexPath.row];
    // Logic of matching tiles
    if (self.firstOpenTile == indexPath && self.secondOpenTile == nil && tile.flipped) {
        return;
    }
    if (self.firstOpenTile == nil || indexPath == self.firstOpenTile) {
        if (!tile.guessed) {
            self.firstOpenTile = indexPath;
            [self flipCellForIndexPath:indexPath];
        }
    } else if (self.firstOpenTile && (self.secondOpenTile == nil || indexPath == self.secondOpenTile)) {
        if (!tile.guessed) {
            LSTile *firstTile = nil;
            if (self.firstOpenTile != nil) {
                firstTile = self.currentGame.tilesSet[self.firstOpenTile.row];
            }
            if (![tile.color isEqual:firstTile.color] && indexPath != self.secondOpenTile) {
                self.secondOpenTile = indexPath;
                self.blockManualFlipping = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self flipCellForIndexPath:self.firstOpenTile];
                    [self flipCellForIndexPath:self.secondOpenTile];
                });
            } else {
                self.firstOpenTile = nil;
                self.secondOpenTile = nil;
                firstTile.guessed = YES;
                tile.guessed = YES;
            }
            [self flipCellForIndexPath:indexPath];
        }
    }
}

- (void)flipCellForIndexPath:(NSIndexPath*)indexPath {
    LSTileCollectionViewCell *cell = (id)[self.collectionView cellForItemAtIndexPath:indexPath];
    LSTile *tile = self.currentGame.tilesSet[indexPath.row];
    UIViewAnimationOptions animationOption = tile.flipped ? UIViewAnimationOptionTransitionFlipFromRight: UIViewAnimationOptionTransitionFlipFromLeft;
    BOOL hideTile = !tile.flipped;
    [UIView transitionWithView:cell
                      duration:0.5
                       options:animationOption
                    animations:^{
                        cell.headImageView.hidden = hideTile;
                    }
                    completion:^(BOOL finished) {
                        if (!tile.flipped) {
                            if (self.secondOpenTile != nil) {
                                self.secondOpenTile = nil;
                            } else if (self.firstOpenTile != nil) {
                                self.firstOpenTile = nil;
                                self.blockManualFlipping = NO;
                            }
                        }
                    }];
    tile.flipped = !tile.flipped;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width / (float)self.currentGame.itemsInLine - kOffset; //  - self.horizontalOffset;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / (float)self.currentGame.itemsInLine - kOffset;
//    CGFloat horizontalOffset = self.currentGame.itemsInLine * kOffset / (float)(self.currentGame.itemsInLine + 1);
    CGFloat fullHeight = [UIScreen mainScreen].bounds.size.height - 20.0;
    CGFloat verticalOffset = (fullHeight - width * self.currentGame.itemsInColumns) / (float)(self.currentGame.itemsInColumns + 1); // self.colsInLine * kHorizontalOffset / (float)(self.colsInLine + 1);
    return UIEdgeInsetsMake(verticalOffset, 5, verticalOffset, 5);
}


//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return self.rowsInLine * self.horizontalOffset / (float)(self.rowsInLine + 1);
//}
//

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat width = [UIScreen mainScreen].bounds.size.width / (float)self.currentGame.itemsInLine - kOffset;
    CGFloat fullHeight = [UIScreen mainScreen].bounds.size.height - 20.0;
    CGFloat result = (fullHeight - width * self.currentGame.itemsInColumns) / (float)(self.currentGame.itemsInColumns);
    return result / 2.0; // self.colsInLine * kHorizontalOffset / (float)(self.colsInLine + 1);
}

- (void)updateTitle {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.navigationItem.title = self.currentGame.timeSpentFormatted;
        [self updateTitle];
    });
}

@end
