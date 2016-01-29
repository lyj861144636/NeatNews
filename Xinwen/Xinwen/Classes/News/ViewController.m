//
//  ViewController.m
//  Xinwen
//
//  Created by hyp on 16/1/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "ImageCel.h"
#import "Channel.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *arrTable;

@end

@implementation ViewController

-(void)setArrTable:(NSArray *)arrTable
{
    _arrTable = arrTable;
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@" %s %@", __func__, NSStringFromCGRect(self.view.frame));
}


-(void)setUrlUrl:(NSString *)urlUrl
{
    _urlUrl = urlUrl;
    
    self.arrTable = nil;
    
    [News loadNewsListWithUrlString:urlUrl finished:^(NSArray *newlist) {
        self.arrTable = newlist;
        NSLog(@"=====%@", _arrTable);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW, ScreenH - 104)  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.estimatedRowHeight = 80;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_arrTable[indexPath.row] imgextra].count == 2) {
        return 120;
    }
    return 70;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.news = _arrTable[indexPath.row];
    
    if ([_arrTable[indexPath.row] imgextra].count == 2) {
        static NSString *identifier1 = @"ImageCell";
        ImageCel *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[ImageCel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        cell1.news = _arrTable[indexPath.row];
        return cell1;
    }
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
