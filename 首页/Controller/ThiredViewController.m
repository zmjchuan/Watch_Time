//
//  ThiredViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ThiredViewController.h"
#import "InfoView.h"
#import "ThirdCell.h"

#define kWScreen [UIScreen mainScreen].bounds.size.width

@interface ThiredViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)InfoView * infoView;

@property (nonatomic,strong)UITableView * myThirdTableView;

@property (nonatomic,strong)UIButton * saveButton;

@end

@implementation ThiredViewController

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
    _myThirdTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_infoView.frame)+10, kWScreen, 70*2) style:(UITableViewStylePlain)];
    _myThirdTableView.backgroundColor = [UIColor yellowColor];
    _myThirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myThirdTableView.delegate = self;
    _myThirdTableView.dataSource = self;
    _myThirdTableView.scrollEnabled = NO;
    [_myThirdTableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"ThirdCELL"];
    [self.view addSubview:_myThirdTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCELL" forIndexPath:indexPath];
    // 选择cell不改变背景颜色
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.selectedButton.tag = indexPath.row+100;
    
    if (indexPath.row == 0) {
        cell.infoLabel.text = @"支付宝";
    } else {
        cell.infoLabel.text = @"微信";
        cell.line.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.myTableView deselectRowAtIndexPath:indexPath animated:NO];
    ThirdCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [self cellButtonAction:cell.selectedButton];
    
    if (indexPath.row == 0) {
        NSLog(@"支付宝");
        
    } else {
        NSLog(@"微信");
    }
}

#pragma mark -- 单选按钮
- (void)cellButtonAction:(UIButton *)button
{
    if (self.saveButton != button) {
        self.saveButton.selected  = !self.saveButton.selected;
        button.selected = !button.selected;
        self.saveButton = button;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70;
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
