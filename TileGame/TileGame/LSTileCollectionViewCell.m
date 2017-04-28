
//
//  LSTileCollectionViewCell.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/28/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTileCollectionViewCell.h"

@implementation LSTileCollectionViewCell

- (void)updateWithModel:(LSTile*)model {
    self.tile = model;
    self.colorView.backgroundColor = model.color;
}

@end
