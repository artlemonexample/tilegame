//
//  LSLibraryViewController.h
//  TileGame
//
//  Created by Artem Kravchenko on 5/5/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSUser.h"

@interface LSLibraryViewController : UITableViewController

@property (nonatomic, strong) LSUser *currentUser;

@end
