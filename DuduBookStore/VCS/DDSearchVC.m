//
//  DDSearchVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDSearchVC.h"
#import "DDSearchHomeCell.h"

#define BOOKIMAGE_ARRAY @[@"shelter1.png",@"shelter5.png",@"newbook10.png"]
#define NAME_ARRAY @[@"繁荣还是危机",@"信任的速度",@"小王子"]
#define WRITER_ARRAY @[@"王宇",@"[美]史蒂芬·柯维",@"[法]圣埃克·苏佩里"]
#define RANK_ARRAY @[@"第一名",@"第二名",@"第三名"]
#define TYPE_ARRAY @[@"经管励志",@"社科历史",@"文学艺术"]
#define DETAIL_ARRAY @[@"繁荣还是危机:后海啸时代的经济迷局》主要内容：危机固然可怕，但更可怕的是繁荣表象掩盖下的危机和对于危机的熟视无睹。剖析历史，目的是为了不再让历史重演！",@"它可以使组织改善业绩，使个人得到提升，使关系更加融洽。在《信任的速度》新书《信任的速度》里，史蒂芬·M·R·柯维通过“五波信任”，“四个核心”以及世界各地高信任度领导者共有的“十三种行为”生动形象地阐述了如何在个人关系和职业生涯中激发和维护信任，层层递进地为我们",@"小王子是一个超凡脱俗的仙童，他住在一颗只比他大一丁点儿的小行星上。陪伴他的是一朵他非常喜爱的小玫瑰花。但玫瑰花的虚荣心伤害了小王子对她的感情。小王子告别小行星，开始了遨游太空的旅行。他先后访问了六个行星，各种见闻使他陷入忧伤，他感到大人们荒唐可笑、太不正常。只有在其中一个点灯人的星球上，小王子才找到一个可以作为朋友的人。但点灯人的"]

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
    [self addRightNavToShelter];
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
    return 3;
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
    cell.booIV.image = [UIImage imageNamed:[BOOKIMAGE_ARRAY objectAtIndex:indexPath.row]];
    cell.nameLB.text = [NAME_ARRAY objectAtIndex:indexPath.row];
    cell.writerLB.text = [WRITER_ARRAY objectAtIndex:indexPath.row];
    cell.typeLB.text = [TYPE_ARRAY objectAtIndex:indexPath.row];
    cell.summaryLB.text = [DETAIL_ARRAY objectAtIndex:indexPath.row];
    cell.countLB.text = [RANK_ARRAY objectAtIndex:indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
