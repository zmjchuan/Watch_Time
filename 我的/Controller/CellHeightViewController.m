//
//  CellHeightViewController.m
//  Watch_Time
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CellHeightViewController.h"
#import "CellHeightCell.h"


@interface CellHeightViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * myTableView;
@property (nonatomic,strong)NSMutableArray * dataAry;
@end

@implementation CellHeightViewController

- (NSMutableArray *)dataAry
{
    if (_dataAry == nil) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 100 * 2) style:(UITableViewStyleGrouped)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor yellowColor];
    [_myTableView registerClass:[CellHeightCell class] forCellReuseIdentifier:@"CELL"];
    [self.view addSubview:_myTableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellHeightCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textL.text = @"大酒";
    [_dataAry addObject:cell.textL.text];
    cell.w = [self weightWithString:cell.textL.text];
    cell.h = [self heightWithString:cell.textL.text];
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * s = _dataAry[indexPath.row];
    CGFloat h = [self heightWithString:s];
    return h;
}


//  用来计算字符串高度  自己定义zhe ge fang fa
- (CGFloat)weightWithString:(NSString *)aString
{
    //
    CGRect r = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.myTableView.frame)-10, 2000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f]} context:nil];
    // 默认字体是17  高度一般+10.因为有的字符串会到下一行，上一行会空出一些空间来
    return r.size.width + 10;
}

//  用来计算字符串高度  自己定义zhe ge fang fa
- (CGFloat)heightWithString:(NSString *)aString
{
    //
    CGRect r = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.myTableView.frame)-10, 2000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f]} context:nil];
    // 默认字体是17  高度一般+10.因为有的字符串会到下一行，上一行会空出一些空间来
    return r.size.height + 10;
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
