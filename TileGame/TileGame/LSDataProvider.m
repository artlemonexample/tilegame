//
//  LSDataProvider.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#define CORE_DATA

#import "LSDataProvider.h"

#import <MagicalRecord/MagicalRecord.h>
#import "FCFileManager.h"

@implementation LSDataProvider

+ (instancetype)sharedInstance {
    static LSDataProvider *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LSDataProvider new];
        NSLog(@"%@", [FCFileManager pathForDocumentsDirectory]);
#ifdef CORE_DATA
        [MagicalRecord setupCoreDataStack];
#endif
    });
    return instance;
}

- (NSArray*)allUsers {
    NSArray *users = nil;
#ifdef CORE_DATA
    NSMutableArray *results = [NSMutableArray array];
    [[LSUserEntity MR_findAllInContext:[NSManagedObjectContext MR_rootSavingContext]] enumerateObjectsUsingBlock:^(__kindof LSUserEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [results addObject:[LSUser userFromEntity:obj]];
    }];
    users = [results copy];
#else
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    users = [NSKeyedUnarchiver unarchiveObjectWithData:[dataBase objectForKey:@"usersLists"]];
#endif
    return users;
}

- (LSUser*)addUser:(LSUser*)user {
#ifdef CORE_DATA
    NSManagedObjectContext *context = [NSManagedObjectContext MR_rootSavingContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"alias", user.alias];
    LSUserEntity *result = [LSUserEntity MR_findAllWithPredicate:predicate inContext:context].firstObject;
    if (result == nil) {
        result = [LSUserEntity MR_createEntityInContext:context];
    }
    [user fillEntityFromUser:result];
    [context MR_saveToPersistentStoreAndWait];
#else
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    NSMutableArray *users = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[dataBase objectForKey:@"usersLists"]]];
    NSInteger index = -1;
    for (int i = 0; i < users.count; i++) {
        LSUser *aUser = users[i];
        if ([aUser.alias isEqualToString:user.alias]) {
            index = i;
            break;
        }
    }
    if (index == -1) {
        [users addObject:user];
    } else {
        [users replaceObjectAtIndex:index withObject:user];
    }
    [dataBase setObject:[NSKeyedArchiver archivedDataWithRootObject:[users copy]] forKey:@"usersLists"];
    [dataBase synchronize];
#endif
    return user;
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


#pragma mark - Getters

- (LSResultEntity*)resultEntityWithID:(NSString*)resultID {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_rootSavingContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"resultID", resultID];
    NSArray *results = [LSResultEntity MR_findAllWithPredicate:predicate inContext:context];
    
    NSAssert(results.count > 1, @"Something going wrong");
    LSResultEntity *result = nil;
    if (results == nil || results.count == 0) {
        result = (id)[LSResultEntity MR_createEntityInContext:context];
        result.resultID = [resultID copy];
    } else {
        result = results.firstObject;
    }
    return result;
}

- (LSTileEntity*)tileEntityWithID:(NSString*)tileID {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_rootSavingContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"tileID", tileID];
    NSArray *results = [LSTileEntity MR_findAllWithPredicate:predicate inContext:context];
    NSAssert(results.count >= 0 && results.count <= 1, @"Something going wrong");
    LSTileEntity *result = nil;
    if (results == nil || results.count == 0) {
        result = (id)[LSTileEntity MR_createEntityInContext:context];
        result.tileID = [tileID copy];
    } else {
        result = results.firstObject;
    }
    return result;
}

- (LSGameEntity*)gameEntityWithID:(NSString*)gameID {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_rootSavingContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"gameID", gameID];
    NSArray *results = [LSGameEntity MR_findAllWithPredicate:predicate inContext:context];
    NSAssert(results.count >= 0 && results.count <= 1, @"Something going wrong");
    LSGameEntity *result = nil;
    if (results == nil || results.count == 0) {
        result = (id)[LSGameEntity MR_createEntityInContext:context];
        result.gameID = [gameID copy];
    } else {
        result = results.firstObject;
    }
    return result;
}

- (LSGameMapEntity*)gameMapEntityForGameID:(NSString*)gameID {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_rootSavingContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"game.gameID", gameID];
    NSArray *results = [LSGameMapEntity MR_findAllWithPredicate:predicate inContext:context];
    NSAssert(results.count >= 0 && results.count <= 1, @"Something going wrong");
    LSGameMapEntity *result = nil;
    if (results == nil || results.count == 0) {
        result = (id)[LSGameMapEntity MR_createEntityInContext:context];
        result.game = [self gameEntityWithID:gameID];
        result.gameMode = result.game.gameMode;
    } else {
        result = results.firstObject;
    }
    return result;
}

@end
