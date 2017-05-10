//
//  LSTile.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "LSTileEntity+CoreDataClass.h"

@interface LSTile : NSObject <NSCoding>

@property (nonatomic, assign) BOOL guessed;
@property (nonatomic, assign) BOOL flipped;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *tileID;
@property (nonatomic, assign) NSInteger order;

- (BOOL)isEqualToTile:(LSTile*)tile;

- (void)fillEntity:(LSTileEntity*)tileEntity;
+ (LSTile*)tileFromEntity:(LSTileEntity*)tileEntity;


@end
