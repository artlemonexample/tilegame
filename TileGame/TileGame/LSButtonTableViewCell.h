//
//  LSButtonTableViewCell.h
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSButtonTableViewCellDelegate <NSObject>

- (void)handleTap:(NSString*)title;

@end

@interface LSButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic, weak) id<LSButtonTableViewCellDelegate> delegate;

@end
