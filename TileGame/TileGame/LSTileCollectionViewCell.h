//
//  LSTileCollectionViewCell.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/28/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSTile.h"

@interface LSTileCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LSTile *tile;

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tileImage;

- (void)updateWithModel:(LSTile*)model;

@end
