//
//  LSUser.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSUser.h"

@interface LSUser ()

@property (nonatomic, strong) NSMutableArray *results;

@end

@implementation LSUser

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.alias = [aDecoder decodeObjectForKey:@"alias"];
        self.currentGame = [aDecoder decodeObjectForKey:@"currentGame"];
        self.results = [aDecoder decodeObjectForKey:@"results"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.alias forKey:@"alias"];
    [aCoder encodeObject:self.currentGame forKey:@"currentGame"];
    [aCoder encodeObject:self.results forKey:@"results"];
}

@end
