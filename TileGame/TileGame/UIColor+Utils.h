//
//  UIColor+Utils.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/9/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

- (NSString *)hexString;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
