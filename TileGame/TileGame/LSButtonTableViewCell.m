//
//  LSButtonTableViewCell.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSButtonTableViewCell.h"

@interface LSButtonTableViewCell ()

@end

@implementation LSButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionButtonDidTap:(UIButton*)sender {
    NSString *title = sender.titleLabel.text;
    [self.delegate handleTap:title];
}

@end
