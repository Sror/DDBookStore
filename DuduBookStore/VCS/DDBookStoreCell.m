//
//  DDBookStoreCell.m
//  DuduBookStore
//
//  Created by Iceland on 14-8-5.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDBookStoreCell.h"

@implementation DDBookStoreCell

- (void)awakeFromNib
{

}

- (void)setDataArray:(NSMutableArray *)array
{
    _dataArray = array;
    [self.scrollView setContentSize:CGSizeMake(83*[self.dataArray count]+14, 150)];
    for (int i=0; i<[self.dataArray count]; i++)
    {
        DDBook *book = [self.dataArray objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(83*i+14, 5, 68, 102);
        [btn setImage:[UIImage imageNamed:book.cover] forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(83*i+14, 110, 68, 13)];
        label1.font = [UIFont systemFontOfSize:11];
        label1.text = book.name;
        if ([book.name length]>6)
        {
            label1.frame = CGRectMake(83*i+14, 110, 68, 30);
            label1.numberOfLines = 0;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
        }
        label1.textColor = [UIColor darkGrayColor];
        [self.scrollView addSubview:label1];
  
        if (!self.isShort)
        {
            UILabel *label2 = [[UILabel alloc] init];
            label2.font = [UIFont systemFontOfSize:9];
            label2.text = book.writer;
            label2.textColor = [UIColor lightGrayColor];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(83*i+14, 139, 68, 11)];
            label3.font = [UIFont systemFontOfSize:9];
            label3.text = book.sort;
            label3.textColor = [UIColor lightGrayColor];
            
            if ([book.name length]>6)
            {
                label2.frame = CGRectMake(83*i+14, 139, 68, 11);
                label3.frame = CGRectMake(83*i+14, 152, 68, 11);
            }
            else
            {
                label2.frame = CGRectMake(83*i+14, 125, 68, 11);
                label3.frame = CGRectMake(83*i+14, 139, 68, 11);
            }
            [self.scrollView addSubview:label2];
            [self.scrollView addSubview:label3];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
