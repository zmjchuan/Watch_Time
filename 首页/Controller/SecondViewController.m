//
//  SecondViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondCell.h"
#import "InfoView.h"

#define kWScreen [UIScreen mainScreen].bounds.size.width
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * myTableView;
@property (nonatomic,strong)InfoView * infoView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:242./255 green:242./255 blue:242./255 alpha:1];
    
    [self initView];
    [self initTableView];
    
}

- (void)initView
{
    _infoView = [[InfoView alloc]initWithFrame:CGRectMake(0, 10, kWScreen, 110)];
    
    [self.view addSubview:_infoView];
}

- (void)initTableView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_infoView.frame)+10, kWScreen, 100*2) style:(UITableViewStylePlain)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.scrollEnabled = NO;
    [_myTableView registerClass:[SecondCell class] forCellReuseIdentifier:@"SecondCELL"];
    [self.view addSubview:_myTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCELL" forIndexPath:indexPath];
    // 选择cell不改变背景颜色
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.myTableView deselectRowAtIndexPath:indexPath animated:NO];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
