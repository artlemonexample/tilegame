//
//  LSGame.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSGame.h"

@implementation LSGame

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
        self.tilesSet = [aDecoder decodeObjectForKey:@"tilesSet"];
        self.imagesOrder = [aDecoder decodeObjectForKey:@"imagesOrder"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.tilesSet forKey:@"tilesSet"];
    [aCoder encodeObject:self.imagesOrder forKey:@"imagesOrder"];
}


- (LSGameMode)gameMode {
    switch (self.imagesOrder.count) {
        case 12:
            return LSGameModeEasy;
            break;
        case 18:
            return LSGameModeMedium;
            break;
        case 24:
            return LSGameModeHard;
            break;
        default:
            return LSGameModeEasy;
            break;
    }
}

@end
