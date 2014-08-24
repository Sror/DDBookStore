//
//  DDSearchVC.h
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "FBViewController.h"

@interface DDSearchVC : FBViewController

@end


@interface Item : NSObject
@property (nonatomic,assign) float x;
@property (nonatomic,assign) float y;
@property (nonatomic,copy) NSString *title;

@end
