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
        self.stopDate = [aDecoder decodeObjectForKey:@"stopDate"];
        self.tilesSet = [aDecoder decodeObjectForKey:@"tilesSet"];
        self.imagesOrder = [aDecoder decodeObjectForKey:@"imagesOrder"];
        self.gameMode = [aDecoder decodeIntegerForKey:@"gameMode"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.gameMode forKey:@"gameMode"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.stopDate forKey:@"stopDate"];
    [aCoder encodeObject:self.tilesSet forKey:@"tilesSet"];
    [aCoder encodeObject:self.imagesOrder forKey:@"imagesOrder"];
}

- (NSInteger)itemsInLine {
    switch (self.gameMode) {
        case LSGameModeEasy:
            return 4;
            break;
            
        case LSGameModeMedium:
            return 5;
            break;
            
        case LSGameModeHard:
            return 6;
            break;
        default:
            return 1;
            break;
    }
}

- (NSInteger)itemsInColumns {
    switch (self.gameMode) {
        case LSGameModeEasy:
            return 5;
            break;
            
        case LSGameModeMedium:
            return 6;
            break;
            
        case LSGameModeHard:
            return 7;
            break;
            
        default:
            return 1;
            break;
    }
}

- (NSTimeInterval)timeSpent {
    if (self.startDate != nil) {
        NSDate *bound = [NSDate date];
        if (self.stopDate != nil) {
            bound = self.stopDate;
        }
        return [bound timeIntervalSinceDate:self.startDate];
    }
    return 0;
}

- (NSString*)timeSpentFormatted {
    NSString *result = nil;
    int seconds = 0, minutes = 0;
    NSTimeInterval timeInterval = self.timeSpent;
    minutes = timeInterval / 60;
    seconds = timeInterval - minutes*60;
    result = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    return result;
}


@end
