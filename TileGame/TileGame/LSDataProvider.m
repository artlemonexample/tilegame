//
//  LSDataProvider.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSDataProvider.h"

@implementation LSDataProvider

+ (instancetype)sharedInstance {
    static LSDataProvider *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LSDataProvider new];
    });
    return instance;
}

- (NSArray*)allUsers {
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    NSArray *users = [NSKeyedUnarchiver unarchiveObjectWithData:[dataBase objectForKey:@"usersLists"]];
    return users;
}

- (LSUser*)addUser:(LSUser*)user {
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    NSMutableArray *users = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[dataBase objectForKey:@"usersLists"]]];
    LSUser *existedUser = nil;
    for (LSUser *aUser in users) {
        if ([aUser.alias isEqualToString:user.alias]) {
            existedUser = aUser;
            break;
        }
    }
    if (existedUser == nil) {
        [users addObject:user];
        [dataBase setObject:[NSKeyedArchiver archivedDataWithRootObject:[users copy]] forKey:@"usersLists"];
        [dataBase synchronize];
    }
    return existedUser;
}

- (void)removeUser:(LSUser*)user {
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    NSMutableArray *users = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[dataBase objectForKey:@"usersLists"]]];
    NSInteger index = -1;
    for (int i = 0; i < users.count; i++) {
        LSUser *currentUser = users[i];
        if ([currentUser.alias isEqualToString:user.alias]) {
            index = i;
            break;
        }
    }
    if (index != -1) {
        [users removeObjectAtIndex:index];
        [dataBase setObject:[NSKeyedArchiver archivedDataWithRootObject:[users copy]] forKey:@"usersLists"];
        [dataBase synchronize];
    }
}

@end
