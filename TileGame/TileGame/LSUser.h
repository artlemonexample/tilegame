//
//  LSUser.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSResult.h"
#import "LSGame.h"

@interface LSUser : NSObject <NSCoding>

@property (nonatomic, strong) NSString *alias;

- (LSGame*)gameForMode:(LSGameMode)gameMode;
- (void)setGame:(LSGame*)game forMode:(LSGameMode)gameMode;

@end
