//
//  LSResult.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSGame.h"

@interface LSResult : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) LSGameMode gameMode;

@end
