//
//  LSDataProvider.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSUser.h"

@interface LSDataProvider : NSObject

+ (instancetype)sharedInstance;

- (NSArray*)allUsers;
- (LSUser*)addUser:(LSUser*)user;
- (void)removeUser:(LSUser*)user;

@end
