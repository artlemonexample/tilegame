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
@property (nonatomic, strong) NSMutableDictionary *games;

@end

@implementation LSUser

- (NSMutableDictionary *)games {
    if (!_games) {
        _games = [NSMutableDictionary dictionary];
    }
    return _games;
}

- (NSMutableArray *)results {
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.alias = [aDecoder decodeObjectForKey:@"alias"];
        self.games = [aDecoder decodeObjectForKey:@"games"];
        self.results = [aDecoder decodeObjectForKey:@"results"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.alias forKey:@"alias"];
    [aCoder encodeObject:self.games forKey:@"games"];
    [aCoder encodeObject:self.results forKey:@"results"];
}

- (LSGame*)gameForMode:(LSGameMode)gameMode{
    return self.games[@(gameMode)];
}

- (void)setGame:(LSGame*)game forMode:(LSGameMode)gameMode {
    self.games[@(gameMode)] = game;
}


@end
