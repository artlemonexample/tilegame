//
//  LSUserEntity+CoreDataProperties.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSUserEntity+CoreDataProperties.h"

@implementation LSUserEntity (CoreDataProperties)

+ (NSFetchRequest<LSUserEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LSUserEntity"];
}

@dynamic alias;
@dynamic results;
@dynamic games;

@end
