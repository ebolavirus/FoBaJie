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
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view.mas_left);
        make.right.mas_equalTo(ws.view.mas_right);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    [self.tableView reloadData];
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
                    if(APPALL.myUserItem.username.length <= 0){
                        cell.textLabel.text = @"尚未编辑资料";
                    } else {
                        cell.textLabel.text = APPALL.myUserItem.username;
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
                    UserDataViewController *vc = [[UserDataViewController alloc] initWithStyle:UITableViewStyleGrouped];
                    vc.myDelegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
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
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"关于软件" message:[NSString stringWithFormat:@"版本：%@\n祈福网是专业从事在线烧香、烧香拜佛、网上拜佛、礼佛、网上许愿的大型专业虚拟现实祭祀软件。您可以在这里免费获取烧香图解、上香图解、观香图、如何看香谱等信息。\n版权所有：上海千沿网络科技有限公司",version] preferredStyle:UIAlertControllerStyleAlert];
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
