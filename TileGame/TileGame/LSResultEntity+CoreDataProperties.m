//
//  LSResultEntity+CoreDataProperties.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSResultEntity+CoreDataProperties.h"

@implementation LSResultEntity (CoreDataProperties)

+ (NSFetchRequest<LSResultEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LSResultEntity"];
}

@dynamic startDate;
@dynamic endDate;
@dynamic gameMode;
@dynamic resultID;
@dynamic user;

@end
