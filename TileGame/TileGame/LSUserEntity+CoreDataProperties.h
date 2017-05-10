//
//  LSUserEntity+CoreDataProperties.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSUserEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSUserEntity (CoreDataProperties)

+ (NSFetchRequest<LSUserEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *alias;
@property (nullable, nonatomic, retain) NSSet<LSResultEntity *> *results;
@property (nullable, nonatomic, retain) NSSet<LSGameMapEntity *> *games;

@end

@interface LSUserEntity (CoreDataGeneratedAccessors)

- (void)addResultsObject:(LSResultEntity *)value;
- (void)removeResultsObject:(LSResultEntity *)value;
- (void)addResults:(NSSet<LSResultEntity *> *)values;
- (void)removeResults:(NSSet<LSResultEntity *> *)values;

- (void)addGamesObject:(LSGameMapEntity *)value;
- (void)removeGamesObject:(LSGameMapEntity *)value;
- (void)addGames:(NSSet<LSGameMapEntity *> *)values;
- (void)removeGames:(NSSet<LSGameMapEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
