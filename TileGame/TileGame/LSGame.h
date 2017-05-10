//
//  LSGame.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "LSTile.h"
#import "NSMutableSet+Merge.h"
#import "LSGameEntity+CoreDataClass.h"
#import "LSGameEntity+CoreDataProperties.h"

extern NSString * const kBaseImageNage;

typedef NS_ENUM(NSUInteger, LSGameMode) {
    LSGameModeEasy,
    LSGameModeMedium,
    LSGameModeHard,
};

@interface LSGame : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *stopDate;
@property (nonatomic, strong) NSArray *tilesSet;
@property (nonatomic, assign) LSGameMode gameMode;
@property (nonatomic, assign) NSTimeInterval gameTime;
@property (nonatomic, strong) NSString *gameID;

- (NSInteger)itemsInLine;
- (NSInteger)itemsInColumns;
- (NSString*)timeSpentFormatted;

+ (LSGame*)gameFromEntity:(LSGameEntity*)gameEntity;
- (void)fillEntityFromGame:(LSGameEntity*)gameEntity;

@end
