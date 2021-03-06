//
//  LSUser.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSGame.h"
#import "LSUserEntity+CoreDataClass.h"
#import "LSUserEntity+CoreDataProperties.h"

@class LSResult, LSGame;

@interface LSUser : NSObject <NSCoding>

@property (nonatomic, strong) NSString *alias;

- (NSArray*)allResults;
- (void)addResult:(LSResult*)result;

- (LSGame*)gameForMode:(LSGameMode)gameMode;
- (void)setGame:(LSGame*)game forMode:(LSGameMode)gameMode;

+ (LSUser*)userFromEntity:(LSUserEntity*)userEntity;
- (void)fillEntityFromUser:(LSUserEntity*)userEntity;

@end
