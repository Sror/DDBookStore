//
//  DDClassifyVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDClassifyVC.h"
#import "DDClassifyCell.h"
#import "DDBookStoreCell.h"

@interface DDClassifyVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DDClassifyVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleName = @"分类";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:FenLei1,FenLei2,FenLei3,FenLei4,nil];
    [self.tableView reloadData];
    
    [self addRightNavToShelter];
}


#define ImageArray1 @[@"newbook6.png",@"newbook7.png",@"newbook8.png",@"newbook9.png",@"newbook10.png"]
#define NameArray1 @[@"男孩成长秘密",@"藏地密码",@"城南旧事",@"不生病的真谛",@"小王子"]
#define WriterArray1 @[@"[美]迈克尔·汤普...",@"何马",@"林海音",@"林弼",@"[法]安东尼·圣埃..."]
#define SortArray1 @[@"亲子少儿",@"文学艺术",@"流行小说",@"生活时尚",@"文学艺术"]

- (NSMutableArray *)fakeData
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:nil];
    for (int j = 0; j<[ImageArray1 count]; j++)
    {
        DDBook *book = [[DDBook alloc] init];
        book.cover = [ImageArray1 objectAtIndex:j];
        book.name = [NameArray1 objectAtIndex:j];
        book.writer = [WriterArray1 objectAtIndex:j];
        book.sort = [SortArray1 objectAtIndex:j];
        [array addObject:book];
    }
    return array;
}
#pragma mark -
#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[self.dataArray count])
        return 195;
    else
        return 136;
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.row<[self.dataArray count])
    {
        DDClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"DDClassifyCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[DDClassifyCell class]])
                {
                    cell = (DDClassifyCell *)oneObject;
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.tagBtn setTitle:[flagStrArray2 objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [cell.tagBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bookStoreFlag%d.png",(int)indexPath.row+1]] forState:UIControlStateNormal];
        cell.array = [self.dataArray objectAtIndex:indexPath.row];
        cell.iv.image = [UIImage imageNamed:[ClassifyArray objectAtIndex:indexPath.row]];
        return cell;
    }
    else
    {
        DDBookStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"DDBookStoreCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[DDBookStoreCell class]])
                {
                    cell = (DDBookStoreCell *)oneObject;
                }
            }
        }
        cell.isShort = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.flagBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bookStoreFlag%d.png",(int)indexPath.row+1]] forState:UIControlStateNormal];
        [cell.flagBtn setTitle:@"畅销推荐" forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataArray = [self fakeData];
        cell.moreBtn.hidden = YES;
        cell.scrollView.showsVerticalScrollIndicator = NO;
        return cell;
    }

}

#pragma mark -
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
