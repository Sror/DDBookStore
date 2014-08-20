//
//  DDClassifyCell.m
//  DuduBookStore
//
//  Created by Iceland on 14-8-20.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDClassifyCell.h"

@implementation DDClassifyCell

- (void)awakeFromNib
{
#define BUTTON_WIDTH 97
#define BUTTON_HEIGHT 30
#define BUTTON_TAG 1000

	for (int i = 0; i < 9; i++)
	{
		int row = i / 3 + 1;
		int column = i % 3 + 1;
		int x = (column - 1) * BUTTON_WIDTH;
		int y = (row - 1) * BUTTON_HEIGHT;
		//创建button 对象
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(x, y, BUTTON_WIDTH, BUTTON_HEIGHT);
		[btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i<[_array count])
        {
            [btn setTitle:[_array objectAtIndex:i] forState:UIControlStateNormal];
        }
        btn.tag = (i + 1 )+BUTTON_TAG;
        [self.classView addSubview:btn];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

#pragma mark -
#pragma mark - Action
- (void)buttonClicked:(UIButton *)sender
{

    
}

@end
