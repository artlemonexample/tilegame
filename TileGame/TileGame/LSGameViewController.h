//
//  LSGameViewController.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/28/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGame.h"

@interface LSGameViewController : UICollectionViewController

@property (nonatomic, strong) LSGame *currentGame;

@end
