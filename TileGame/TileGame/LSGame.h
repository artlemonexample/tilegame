//
//  LSGame.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//


#import <Foundation/Foundation.h>

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
@property (nonatomic, strong) NSIndexSet *imagesOrder;

- (NSInteger)itemsInLine;
- (NSInteger)itemsInColumns;

- (NSString*)timeSpentFormatted;

@end
