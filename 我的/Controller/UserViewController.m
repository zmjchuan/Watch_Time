//
//  UserViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UserViewController.h"
#import "TakePicker.h"
#import "SavePicture.h"
#import "VedioPlayerViewController.h"
#import "AutoLayoutViewController.h"
#import "CellHeightViewController.h"
#import "OrderListViewController.h"

#define kWScreen self.view.frame.size.width
#define kHScreen self.view.frame.size.height
#define iOS8  ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES :NO)

#define kContentSizeH 300

#define kContentSizeHForNormal 200

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITableViewCellEditingStyle _style;
}

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)UIImageView * headImageView;

@property (nonatomic,strong)UIButton * addHeadImageBtn;

@property (nonatomic,strong)NSArray * cellDataArray;
@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTabelView];
    
    _cellDataArray = @[@"视频播放-Masonry布局",@"演示例子-AutoLayOut布局",@"我的订单",@"cell高度&&宽度自适应"];
    // 下拉放大效果
//    [self addHeadImageViewForZoom];
    
    // 下拉没有效果
    [self addHeadImageViewForNormal];
}

#pragma mark ---------------- 添加tableView
- (void)addTabelView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];

}

#pragma  mark ---------------- 下拉放大效果
- (void)addHeadImageViewForZoom
{
    // 设置内边距之后，tableView的原点在（0，kContentSizeH*0.8）的位置
    self.tableView.contentInset = UIEdgeInsetsMake(kContentSizeH*0.8-20, 0, 0, 0);
    
    
    // 相对于tableView的原点，headImageView的原点在原点上方，所以是 y = -kContentSizeH
    UIImageView * headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kContentSizeH, kWScreen, kContentSizeH)];
    headImageView.image = [UIImage imageNamed:@"pic.jpg"];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:headImageView atIndex:0];
    self.headImageView = headImageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"下拉的距离<---> %f",-kContentSizeH*0.8- scrollView.contentOffset.y);
    // cell向下降了多少 高度就增加多少  cell相对下降距离 =（原点-移动的距离）
    CGFloat down = -kContentSizeH*0.8- scrollView.contentOffset.y;
    
    if (down < 0) return;
    CGRect frame = self.headImageView.frame;
    frame.size.height =kContentSizeH+ down*2;
    self.headImageView.frame = frame;
}


#pragma mark ---------------- 下拉没有效果
- (void)addHeadImageViewForNormal
{
    // 设置内边距之后，tableView的原点在（0，kContentSizeH*0.8）的位置
    self.tableView.contentInset = UIEdgeInsetsMake(kContentSizeHForNormal-20, 0, 0, 0);
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, -kContentSizeHForNormal, kWScreen, kContentSizeHForNormal)];
    
    [self.tableView insertSubview:headView atIndex:0];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic.jpg"]];
    imageView.frame = CGRectMake(0, 0, kWScreen, kContentSizeHForNormal);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    imageView.layer.masksToBounds = YES;
    [headView addSubview:imageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addHeadImagePhoto)];
    [imageView addGestureRecognizer:tap];
    
    // 头像按钮
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(kWScreen*0.5-50, kContentSizeHForNormal*0.5-50,100,100);
    btn.backgroundColor = [UIColor yellowColor];
    btn.layer.cornerRadius = 50;
    [btn addTarget:self action:@selector(addHeadImagePhoto) forControlEvents:(UIControlEventTouchUpInside)];
    btn.layer.masksToBounds = YES;
    self.addHeadImageBtn = btn;
    UIImage * image = [SavePicture GetImageFromLocel:@"image"];
    if (image) {
        [self.addHeadImageBtn setBackgroundImage:image forState:(UIControlStateNormal)];
    }
    [headView addSubview:self.addHeadImageBtn];
}

#pragma mark --  添加头像Action
- (void)addHeadImagePhoto
{
    [TakePicker sharePickerBlock:^(UIImage *image) {
        [self.addHeadImageBtn setBackgroundImage:image forState:(UIControlStateNormal)];
        NSLog(@"image %@",image);
        [SavePicture SaveImageToLocal:image keys:@"image"];

    }];
    
    /*if (iOS8) {
        UIAlertController  * alertController = [UIAlertController alertControllerWithTitle:@"获取照片" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        // 是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            
            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                // 相机
                UIImagePickerController * imagePickController = [[UIImagePickerController alloc]init];
                imagePickController.delegate = self;
                imagePickController.allowsEditing = YES;
                imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePickController  animated:YES completion:nil];
            }];
            [alertController addAction:defaultAction];
        }
        
        UIAlertAction * defaultAction1 = [UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            // 相册
            UIImagePickerController * imagePickController = [[UIImagePickerController alloc]init];
            imagePickController.delegate = self;
            imagePickController.allowsEditing = YES;
            imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePickController  animated:YES completion:nil];
        }];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancelAction];
        
        [alertController addAction:defaultAction1];
        
        // 弹出视图
        [self presentViewController:alertController animated:YES completion:nil];

    }*/
}

#pragma mark ---------------- image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.addHeadImageBtn setBackgroundImage:image forState:(UIControlStateNormal)];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark ---------------- dataSource && delegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
   

    cell.textLabel.text = _cellDataArray[indexPath.row];
   
    return cell;
}

// - 点击tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 展示了tabbar的隐藏的几种方法
    if(indexPath.row == 0)
    {
        VedioPlayerViewController * vedioPlayer = [[VedioPlayerViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vedioPlayer animated:YES];
        self.hidesBottomBarWhenPushed  = NO;
        
    } else if (indexPath.row == 1) {
        AutoLayoutViewController * autoLayoutVC = [[AutoLayoutViewController alloc]init];
        autoLayoutVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:autoLayoutVC animated:YES];
    } else if (indexPath.row == 2){
        OrderListViewController  * list  = [[OrderListViewController alloc]init];
        list.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:list animated:YES];
        
        
    } else {
        CellHeightViewController * cellVC = [[CellHeightViewController alloc]init];
        [self.navigationController pushViewController:cellVC animated:YES];
    }
}

// cell手势滑动
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//        [self.deleteData removeObjectAtIndex:indexPath.row];
//        
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    }];
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"教师" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
//        [self.deleteData exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
//        
//        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//        
//        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
         NSLog(@"图书");
        
    }];
    
    topRowAction.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"图书" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"图书");
        
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }];
   moreRowAction.backgroundColor = [UIColor yellowColor];
    return @[topRowAction,moreRowAction];
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [UIScreen mainScreen].bounds.size.width*0.32;
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
