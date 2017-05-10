//
//  LSGameMapEntity+CoreDataProperties.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSGameMapEntity+CoreDataProperties.h"

@implementation LSGameMapEntity (CoreDataProperties)

+ (NSFetchRequest<LSGameMapEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LSGameMapEntity"];
}

@dynamic gameMode;
@dynamic game;
@dynamic user;

@end
