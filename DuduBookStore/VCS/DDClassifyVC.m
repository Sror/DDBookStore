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

- (NSMutableArray *)fakeData
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:nil];
    for (int j = 0; j<[bookImageArray1 count]; j++)
    {
        DDBook *book = [[DDBook alloc] init];
        book.cover = [bookImageArray1 objectAtIndex:j];
        book.name = [booknameArray1 objectAtIndex:j];
        book.writer = [bookwriterArray1 objectAtIndex:j];
        book.sort = [bookSortArray1 objectAtIndex:j];
        [array addObject:book];
    }
    return array;
}
#pragma mark -
#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[self.dataArray count]-1)
        return 195;
    else
        return 136;
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.row!=[self.dataArray count]-1)
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
        [cell.flagBtn setTitle:[flagStrArray1 objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataArray = [self fakeData];
        return cell;
    }

}

#pragma mark -
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
