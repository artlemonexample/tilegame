//
//  LSTile.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSTile : NSObject <NSCoding>

@property (nonatomic, assign) BOOL guessed;
@property (nonatomic, strong) NSString *imageName;

@end
