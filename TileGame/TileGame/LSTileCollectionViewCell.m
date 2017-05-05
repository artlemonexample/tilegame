
//
//  LSTileCollectionViewCell.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/28/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTileCollectionViewCell.h"

#import "FCFileManager.h"

@implementation LSTileCollectionViewCell

- (void)updateWithModel:(LSTile*)model {
    self.tile = model;
    self.tileImage.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@", [FCFileManager pathForLibraryDirectory], model.imageName]];
    self.colorView.backgroundColor = model.color;
    self.headImageView.hidden = model.guessed;
}

@end
