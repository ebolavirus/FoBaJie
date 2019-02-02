//
//  WodeViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/8/31.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "WodeViewController.h"
#import "UserDataViewController.h"
#import "GuanyuViewController.h"
#import <FlatUIKit.h>
#import <Masonry.h>
#import "AppDelegate.h"

@interface WodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIImageView *bgView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) FUIButton *logoutButton;

@end

@implementation WodeViewController

@synthesize bgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        
        self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg"]];
        self.bgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:bgView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,0,0) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.view addSubview:self.tableView];
        
        self.logoutButton = [FUIButton new];
        self.logoutButton.buttonColor = MMColorRed;
        self.logoutButton.shadowColor = MMColorShadowRed;
        self.logoutButton.shadowHeight = 3.0f;
        self.logoutButton.cornerRadius = 6.0f;
        self.logoutButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.logoutButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.logoutButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        [self.logoutButton setTitle:@"注销" forState:UIControlStateNormal];
        [self.logoutButton addTarget:self action:@selector(logoutPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.logoutButton];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    WS(ws);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.bgView.intrinsicContentSize.height);
        make.left.mas_equalTo(ws.view.mas_left);
        make.right.mas_equalTo(ws.view.mas_right);
        make.top.mas_equalTo(ws.view.mas_top);
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).with.offset(20);
        make.right.mas_equalTo(ws.view).with.offset(-20);
        make.bottom.mas_equalTo(ws.view.mas_bottom).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view.mas_left);
        make.right.mas_equalTo(ws.view.mas_right);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.bottom.mas_equalTo(self.logoutButton.mas_top).with.offset(-10);
    }];
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        [self.logoutButton setTitle:@"注销" forState:UIControlStateNormal];
    } else {
        [self.logoutButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

-(void)logoutPressed:(id)sender{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"注销" message:@"确认退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *ok1Action = [UIAlertAction actionWithTitle:@"继续注销"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [AVUser logOut];
            [APPALL showLoginWindow];
        }];
        [vc addAction:ok1Action];
        [vc addAction:cancelAction];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self presentViewController:vc animated:YES completion:nil];
		});
    } else {
        [APPALL showLoginWindow];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        default:
            return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"characteristicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    AVUser *currentUser = [AVUser currentUser];
                    if (currentUser != nil) {
                        cell.textLabel.text = currentUser.username;
                        cell.detailTextLabel.text = @"编辑资料";
                    }else{
                        cell.textLabel.text = @"尚未登录";
                    }
                }
                    break;
                case 1:{
                    cell.textLabel.text = @"功德值";
                    cell.detailTextLabel.text = @"80";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"关于";
                    cell.detailTextLabel.text = @"";
                }
                    break;
                case 1:{
                    cell.textLabel.text = @"声明";
                    cell.detailTextLabel.text = @"";
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return cell;
}

-(void)reloadListView{
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    AVUser *currentUser = [AVUser currentUser];
                    if (currentUser != nil) {
                        UserDataViewController *vc = [[UserDataViewController alloc] initWithStyle:UITableViewStyleGrouped];
                        vc.myDelegate = self;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [APPALL showLoginWindow];
                    }
                }
                    break;
                case 1:{
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//app版本号 Version
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"关于软件" message:[NSString stringWithFormat:@"版本：%@\n版权所有：上海千沿网络科技有限公司",version] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
                    [vc addAction:cancelAction];
					dispatch_async(dispatch_get_main_queue(), ^{
						[self presentViewController:vc animated:YES completion:nil];
					});
                }
                    break;
                case 1:{
                    GuanyuViewController *vc = [GuanyuViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

@end
