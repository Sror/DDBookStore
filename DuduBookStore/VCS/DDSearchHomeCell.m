//
//  DDSearchHomeCell.m
//  DuduBookStore
//
//  Created by Iceland on 14-8-24.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDSearchHomeCell.h"

@implementation DDSearchHomeCell

- (void)awakeFromNib
{
    self.countLB.transform = CGAffineTransformMakeRotation(M_PI*45/180);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
