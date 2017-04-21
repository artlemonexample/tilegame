//
//  LSResult.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSResult.h"

@implementation LSResult

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
        self.gameMode = [aDecoder decodeIntegerForKey:@"gameMode"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    [aCoder encodeInteger:self.gameMode forKey:@"gameMode"];
}

@end
