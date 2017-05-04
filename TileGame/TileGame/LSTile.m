//
//  LSTile.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTile.h"

@implementation LSTile

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.flipped = [aDecoder decodeObjectForKey:@"flipped"];
        self.guessed = [aDecoder decodeBoolForKey:@"guessed"];
        self.color = [aDecoder decodeObjectForKey:@"color"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeInteger:self.flipped forKey:@"flipped"];
    [aCoder encodeBool:self.guessed forKey:@"guessed"];
    [aCoder encodeObject:self.color forKey:@"color"];
}

- (BOOL)isEqualToTile:(LSTile*)tile {
    return [self.color isEqual:tile.color];
}

@end
