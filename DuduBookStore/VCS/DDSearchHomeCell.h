//
//  DDSearchHomeCell.h
//  DuduBookStore
//
//  Created by Iceland on 14-8-24.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSearchHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *booIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *writerLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *summaryLB;



@property (weak, nonatomic) IBOutlet UILabel *countLB;

@end
