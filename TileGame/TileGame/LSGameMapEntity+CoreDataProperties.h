//
//  LSGameMapEntity+CoreDataProperties.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSGameMapEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSGameMapEntity (CoreDataProperties)

+ (NSFetchRequest<LSGameMapEntity *> *)fetchRequest;

@property (nonatomic) int16_t gameMode;
@property (nullable, nonatomic, retain) LSGameEntity *game;
@property (nullable, nonatomic, retain) LSUserEntity *user;

@end

NS_ASSUME_NONNULL_END
