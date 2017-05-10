//
//  NSMutableSet+Merge.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/9/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "NSMutableSet+Merge.h"

@implementation NSMutableSet (Merge)

- (void)mergeFromSet:(NSSet*)updateSet
                 addBlock:(void(^)(id))addBlock
              deleteBlock:(void(^)(id))deleteBlock
{
    [updateSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        if (![self containsObject:obj])
        {
            addBlock(obj);
        }
    }];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        if (![updateSet containsObject:obj])
        {
            deleteBlock(obj);
        }
    }];
}

@end
