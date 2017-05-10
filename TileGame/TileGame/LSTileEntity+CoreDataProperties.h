//
//  LSTileEntity+CoreDataProperties.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSTileEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSTileEntity (CoreDataProperties)

+ (NSFetchRequest<LSTileEntity *> *)fetchRequest;

@property (nonatomic) BOOL guessed;
@property (nonatomic) BOOL flipped;
@property (nullable, nonatomic, copy) NSString *imageName;
@property (nullable, nonatomic, copy) NSString *color;
@property (nonatomic) int16_t order;
@property (nullable, nonatomic, copy) NSString *tileID;
@property (nullable, nonatomic, retain) LSGameEntity *game;

@end

NS_ASSUME_NONNULL_END
