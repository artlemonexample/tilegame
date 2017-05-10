//
//  LSUser.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSUser.h"

#import "LSGameMapEntity+CoreDataProperties.h"
#import "LSDataProvider.h"
#import "LSResult.h"
#import "LSGame.h"

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

- (NSArray *)allResults {
    return [self.results copy];
}

- (void)addResult:(LSResult *)result {
    [self.results addObject:result];
}


#pragma mark - Mapping

+ (LSUser*)userFromEntity:(LSUserEntity*)userEntity {
    LSUser *result = [LSUser new];
    result.alias = [userEntity.alias copy];
    // Result
    NSMutableArray *resultsSet = [NSMutableArray array];
    [userEntity.results enumerateObjectsUsingBlock:^(LSResultEntity * _Nonnull obj, BOOL * _Nonnull stop) {
        [resultsSet addObject:[LSResult resultFromEntity:obj]];
    }];
    result.results = [resultsSet copy];
    // Games
    NSMutableDictionary *gamesDictionary = [NSMutableDictionary dictionary];
    [userEntity.games enumerateObjectsUsingBlock:^(LSGameMapEntity * _Nonnull obj, BOOL * _Nonnull stop) {
        [gamesDictionary setObject:[LSGame gameFromEntity:obj.game] forKey:@(obj.gameMode)];
    }];
    result.games = gamesDictionary;
    return result;
}

- (void)fillEntityFromUser:(LSUserEntity*)userEntity {
    userEntity.alias = [self.alias copy];
    // Results
    NSMutableSet *resultsSet = [NSMutableSet set];
    [self.results enumerateObjectsUsingBlock:^(LSResult* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LSResultEntity *resultEntity = [[LSDataProvider sharedInstance] resultEntityWithID:obj.resultID];
        [obj fillEntity:resultEntity];
        [resultsSet addObject:resultEntity];
    }];
    [[userEntity mutableSetValueForKey:@"results"] mergeFromSet:resultsSet addBlock:^(LSResultEntity *resultEntity) {
        [userEntity addResultsObject:resultEntity];
    } deleteBlock:^(LSResultEntity *resultEntity) {
        [userEntity removeResultsObject:resultEntity];
    }];
    // Games
    NSMutableSet *gamesSet = [NSMutableSet set];
    [self.games enumerateKeysAndObjectsUsingBlock:^(NSNumber *gameMode, LSGame *obj, BOOL * _Nonnull stop) {
        LSGameMapEntity *gameMapEntity = [[LSDataProvider sharedInstance] gameMapEntityForGameID:obj.gameID];
        gameMapEntity.gameMode = gameMode.integerValue;
        [obj fillEntityFromGame:gameMapEntity.game];
        [gamesSet addObject:gameMapEntity];
    }];
    [[userEntity mutableSetValueForKey:@"games"] mergeFromSet:gamesSet addBlock:^(LSGameMapEntity *gameMapEntity) {
        [userEntity addGamesObject:gameMapEntity];
    } deleteBlock:^(LSGameMapEntity *gameMapEntity) {
        [userEntity addGamesObject:gameMapEntity];
    }];
}


@end
