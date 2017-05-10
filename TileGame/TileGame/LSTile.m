//
//  LSTile.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTile.h"

#import "UIColor+Utils.h"

@implementation LSTile

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.flipped = [aDecoder decodeObjectForKey:@"flipped"];
        self.guessed = [aDecoder decodeBoolForKey:@"guessed"];
        self.color = [aDecoder decodeObjectForKey:@"color"];
        self.order = [aDecoder decodeIntegerForKey:@"order"];
        self.tileID = [aDecoder decodeObjectForKey:@"tileID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.order forKey:@"order"];
    [aCoder encodeObject:self.tileID forKey:@"tileID"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeInteger:self.flipped forKey:@"flipped"];
    [aCoder encodeBool:self.guessed forKey:@"guessed"];
    [aCoder encodeObject:self.color forKey:@"color"];
}

- (BOOL)isEqualToTile:(LSTile*)tile {
    return [self.color isEqual:tile.color];
}


#pragma mark - Mapping

+ (LSTile*)tileFromEntity:(LSTileEntity*)tileEntity {
    LSTile *tile = [LSTile new];
    tile.tileID = [tileEntity.tileID copy];
    tile.flipped = tileEntity.flipped;
    tile.guessed = tileEntity.guessed;
    tile.order = tileEntity.order;
    tile.color = [UIColor colorFromHexString:tileEntity.color];
    tile.imageName = [tileEntity.imageName copy];
    return tile;
}

- (void)fillEntity:(LSTileEntity*)tileEntity {
    tileEntity.tileID = [self.tileID copy];
    tileEntity.order = self.order;
    tileEntity.flipped = self.flipped;
    tileEntity.guessed = self.guessed;
    tileEntity.color = self.color.hexString;
    tileEntity.imageName = [self.imageName copy];
}


@end
