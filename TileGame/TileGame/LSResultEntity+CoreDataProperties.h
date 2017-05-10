//
//  LSResultEntity+CoreDataProperties.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/10/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LSResultEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSResultEntity (CoreDataProperties)

+ (NSFetchRequest<LSResultEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nonatomic) int16_t gameMode;
@property (nullable, nonatomic, copy) NSString *resultID;
@property (nullable, nonatomic, retain) LSUserEntity *user;

@end

NS_ASSUME_NONNULL_END
