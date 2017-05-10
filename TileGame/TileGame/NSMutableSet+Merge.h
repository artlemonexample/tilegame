//
//  NSMutableSet+Merge.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/9/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (Merge)

- (void)mergeFromSet:(NSSet*)updateSet
            addBlock:(void(^)(id))addBlock
         deleteBlock:(void(^)(id))deleteBlock;

@end
