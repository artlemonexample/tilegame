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

@end

@implementation LSGameViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"tile_cell"];
    [self.collectionView reloadData];
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

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LSTileCollectionViewCell *cell = (id)[self.collectionView cellForItemAtIndexPath:indexPath];
    LSTile *firsTile = nil;
    if (self.firstOpenTile != nil) {
        firsTile = self.currentGame.tilesSet[self.firstOpenTile.row];
    }
    LSTile *tile = self.currentGame.tilesSet[indexPath.row];
    if (self.firstOpenTile == nil) {
        self.firstOpenTile = indexPath;
    } else if (self.secondOpenTile == nil) {
        self.secondOpenTile = indexPath;
        if (![tile.color isEqual:firsTile.color]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self collectionView:collectionView didSelectItemAtIndexPath:self.firstOpenTile];
                [self collectionView:collectionView didSelectItemAtIndexPath:self.secondOpenTile];
                self.firstOpenTile = nil;
                self.secondOpenTile = nil;
            });
        } else {
            self.firstOpenTile = nil;
            self.secondOpenTile = nil;
        }
    }
    if (tile.flipped) {
        [UIView transitionFromView:cell.colorView toView:cell.headImageView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:^(BOOL finished) {
//                            cell.headImageView.alpha = 1.0;
                        }];
    } else {
        [UIView transitionFromView:cell.headImageView  toView:cell.colorView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:^(BOOL finished) {
//                            cell.headImageView.alpha = 0.0;
                        }];
    }
    
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


@end
