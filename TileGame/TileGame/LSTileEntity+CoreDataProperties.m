//
//  LSTileEntity+CoreDataProperties.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSTileEntity+CoreDataProperties.h"

@implementation LSTileEntity (CoreDataProperties)

+ (NSFetchRequest<LSTileEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LSTileEntity"];
}

@dynamic guessed;
@dynamic flipped;
@dynamic imageName;
@dynamic color;
@dynamic order;
@dynamic tileID;
@dynamic game;

@end
