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
        self.guessed = [aDecoder decodeBoolForKey:@"guessed"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeBool:self.guessed forKey:@"guessed"];
}

@end
