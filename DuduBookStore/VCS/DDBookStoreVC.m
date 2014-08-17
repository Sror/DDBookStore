//
//  DDBookStoreVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDBookStoreVC.h"
#import "DDBookStoreCell.h"
#import "DDBook.h"
#import "DDBookshelfVC.h"

@interface DDBookStoreVC ()<UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@interface DDBookStoreVC ()

@end

@implementation DDBookStoreVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleName = @"书馆";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 35;
    self.tableView.sectionFooterHeight = 10;
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionLeft | PPRevealSideDirectionRight];
    self.revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionContentView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f,60, 30);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"书架" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightNavAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (NSMutableArray *)fakeData
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:nil];
    NSMutableArray *arrayUtils1 = [[NSMutableArray alloc] initWithObjects:bookImageArray1,bookImageArray2,bookImageArray3,bookImageArray4,bookImageArray5,nil];
    NSMutableArray *arrayUtils2 = [[NSMutableArray alloc] initWithObjects:booknameArray1,booknameArray2,booknameArray3,booknameArray4,booknameArray5,nil];
    NSMutableArray *arrayUtils3 = [[NSMutableArray alloc] initWithObjects:bookwriterArray1,bookwriterArray2,bookwriterArray3,bookwriterArray4,bookwriterArray5,nil];
    NSMutableArray *arrayUtils4 = [[NSMutableArray alloc] initWithObjects:bookSortArray1,bookSortArray2,bookSortArray3,bookSortArray4,bookSortArray5,nil];

    for (int i=0; i<5; i++)
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:nil];
        NSArray *imageArray = [arrayUtils1 objectAtIndex:i];
        for (int j = 0; j<[imageArray count]; j++)
        {
            DDBook *book = [[DDBook alloc] init];
            book.cover = [[arrayUtils1 objectAtIndex:i] objectAtIndex:j];
            book.name = [[arrayUtils2 objectAtIndex:i] objectAtIndex:j];
            book.writer = [[arrayUtils3 objectAtIndex:i] objectAtIndex:j];
            book.sort = [[arrayUtils4 objectAtIndex:i] objectAtIndex:j];
            [array addObject:book];
        }
        [dataArray addObject:array];
    }

    return dataArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self fakeData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
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
    [cell.flagBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bookStoreFlag%d.png",(int)indexPath.row+1]] forState:UIControlStateNormal];
    [cell.flagBtn setTitle:[flagStrArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataArray = [[self fakeData] objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



# pragma mark -
# pragma mark - Action
- (void)rightNavAction:(UIButton *)btn
{
    [self.revealSideViewController popViewControllerAnimated:YES];
}

@end