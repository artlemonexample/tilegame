//
//  LSGameEntity+CoreDataProperties.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSGameEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSGameEntity (CoreDataProperties)

+ (NSFetchRequest<LSGameEntity *> *)fetchRequest;

@property (nonatomic) int64_t gameTime;
@property (nonatomic) int16_t gameMode;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *stopDate;
@property (nullable, nonatomic, copy) NSString *gameID;
@property (nullable, nonatomic, retain) NSSet<LSTileEntity *> *tilesSet;
@property (nullable, nonatomic, retain) LSGameMapEntity *gameMap;

@end

@interface LSGameEntity (CoreDataGeneratedAccessors)

- (void)addTilesSetObject:(LSTileEntity *)value;
- (void)removeTilesSetObject:(LSTileEntity *)value;
- (void)addTilesSet:(NSSet<LSTileEntity *> *)values;
- (void)removeTilesSet:(NSSet<LSTileEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
