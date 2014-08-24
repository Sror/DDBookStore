//
//  DDSearchVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDSearchVC.h"
#import "DDSearchHomeCell.h"

@interface DDSearchVC ()<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIButton *tagBtn1;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn2;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn3;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn4;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn5;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn6;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn7;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn8;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn9;

@property (weak, nonatomic) IBOutlet UIButton *aniBtn;

@property (strong, nonatomic) NSMutableArray *centerArray;
@property (strong, nonatomic) NSMutableArray *strArray;




- (IBAction)annimationAction:(id)sender;

@end

@implementation Item

@end

@implementation DDSearchVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleName = @"搜索";
        self.strArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 129;

    [self getCenterArray];
}

#define TAGBTN_TAG 100
- (void)getCenterArray
{
    self.centerArray = [[NSMutableArray alloc] init];
    for (int i=0; i<9; i++)
    {
        UIButton *tagBtn = (UIButton *)[self.view viewWithTag:TAGBTN_TAG+i+1];
        Item *item = [[Item alloc] init];
        item.x = tagBtn.center.x;
        item.y = tagBtn.center.y;
        item.title = tagBtn.titleLabel.text;
        [self.centerArray addObject:item];
        [self.strArray addObject:item.title];
    }
}

- (NSMutableArray *)randomizedArrayWithArray:(NSArray *)array
{
    NSMutableArray *results = [[NSMutableArray alloc]initWithArray:array];
    int i = [results count];
    while(--i > 0)
    {
        int j = rand() % (i+1);
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return results;
}

#pragma mark -
#pragma mark - Action
- (IBAction)annimationAction:(id)sender
{
    for (int i=0; i<9; i++)
    {
        UIButton *tagBtn = (UIButton *)[self.view viewWithTag:TAGBTN_TAG+i+1];
        [tagBtn setTitle:@"" forState:UIControlStateNormal];
        tagBtn.center = CGPointMake(160,124);
    }
    self.strArray = [self randomizedArrayWithArray:self.strArray];
    if (self.centerArray)
    {
        [UIView animateWithDuration:1 animations:^{
            
            for (int i=0; i<9; i++)
            {
                UIButton *tagBtn = (UIButton *)[self.view viewWithTag:TAGBTN_TAG+i+1];
                [tagBtn setTitle:[self.strArray objectAtIndex:i] forState:UIControlStateNormal];
                Item *item = [self.centerArray objectAtIndex:i];
                tagBtn.center = CGPointMake(item.x,item.y);
                [self.centerArray addObject:item];
            }
        
        }];
    }
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DDSearchHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"DDSearchHomeCell" owner:self options:nil];
        for (id oneObject in cellNib)
        {
            if ([oneObject isKindOfClass:[DDSearchHomeCell class]])
            {
                cell = (DDSearchHomeCell *)oneObject;
            }
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
