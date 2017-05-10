//
//  LSGameEntity+CoreDataProperties.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSGameEntity+CoreDataProperties.h"

@implementation LSGameEntity (CoreDataProperties)

+ (NSFetchRequest<LSGameEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LSGameEntity"];
}

@dynamic gameTime;
@dynamic gameMode;
@dynamic startDate;
@dynamic stopDate;
@dynamic gameID;
@dynamic tilesSet;
@dynamic gameMap;

@end
