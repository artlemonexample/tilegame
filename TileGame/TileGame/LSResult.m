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
        self.resultID = [aDecoder decodeObjectForKey:@"resultID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.resultID forKey:@"resultID"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    [aCoder encodeInteger:self.gameMode forKey:@"gameMode"];
}


#pragma mark - Mapping

+ (LSResult*)resultFromEntity:(LSResultEntity*)resultEntity {
    LSResult *result = [LSResult new];
    result.resultID = [resultEntity.resultID copy];
    result.startDate = [resultEntity.startDate copy];
    result.endDate = [resultEntity.endDate copy];
    result.gameMode = resultEntity.gameMode;
    return result;
}

- (void)fillEntity:(LSResultEntity*)resultEntity {
    resultEntity.resultID = [self.resultID copy];
    resultEntity.startDate = [self.startDate copy];
    resultEntity.endDate = [self.endDate copy];
    resultEntity.gameMode = self.gameMode;
}


@end
