//
//  HuanyuanViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/10/2.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "HuanyuanViewController.h"
#import "YuanwangViewController.h"
#import <Masonry.h>
#import "AppDelegate.h"
#import <SVProgressHUD.h>
#import <FlatUIKit.h>
#import "YuanDetailViewController.h"
#import "YwEditVController.h"
#import "YWTableViewCell.h"
#import <KGModal.h>
#import "tooles.h"
#import <MJRefresh.h>

@interface HuanyuanViewController ()<UITableViewDelegate,UITableViewDataSource,ydDelegate>

@property(nonatomic,strong) NSArray *wishArray;
@property(nonatomic,strong) UITableView *listView;
@property(nonatomic,strong) UILabel *singleToolbar;
@property(nonatomic,strong) UISegmentedControl *mySegment;
@property(nonatomic,strong) FUIButton *xyButton;
@property(nonatomic,strong) MJRefreshNormalHeader *listheader;
@property(nonatomic,strong) MJRefreshAutoNormalFooter *listfooter;
@property(nonatomic,assign) NSInteger nowPage;
@property(nonatomic,assign) NSInteger pageEleCount;

@property(nonatomic,strong) YuanDetailViewController *ydVC;

@end

@implementation HuanyuanViewController

@synthesize nowPage;
@synthesize pageEleCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.view.backgroundColor = MMColorOrange;
		
		self.nowPage = 0;
		self.pageEleCount = 30;
		
		self.wishArray = [NSArray array];
		self.singleToolbar = [UILabel new];
		self.singleToolbar.backgroundColor = MMColorRed;
		[self.view addSubview:self.singleToolbar];
		
		self.mySegment = [[UISegmentedControl alloc] initWithItems:@[@"许愿列表",@"我的许愿"]];
		[self.mySegment setTintColor:[UIColor whiteColor]];
		[self.mySegment setBackgroundColor:MMColorRed];
		self.mySegment.selectedSegmentIndex = 0;
		[self.mySegment addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
		[self.view addSubview:self.mySegment];
		
		self.listView = [UITableView new];
		self.listView.backgroundColor = [UIColor clearColor];
		self.listView.dataSource = self;
		self.listView.delegate = self;
		self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		self.listheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
			// 进入刷新状态后会自动调用这个block
			[self queryTheList:YES];
		}];
		self.listheader.lastUpdatedTimeLabel.hidden = YES;
		[self.listheader setTitle:@"下拉进行刷新" forState:MJRefreshStateIdle];
		[self.listheader setTitle:@"松开刷新" forState:MJRefreshStatePulling];
		[self.listheader setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
		self.listheader.stateLabel.textColor = [UIColor whiteColor];
		self.listheader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
		self.listView.mj_header = self.listheader;
		
		self.listfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
			[self queryTheList:NO];
		}];
		[self.listfooter setTitle:@"继续上拉加载更多" forState:MJRefreshStateIdle];
		[self.listfooter setTitle:@"加载中……" forState:MJRefreshStateRefreshing];
		[self.listfooter setTitle:@"到尽头啦" forState:MJRefreshStateNoMoreData];
		self.listfooter.stateLabel.textColor = [UIColor whiteColor];
		self.listView.mj_footer = self.listfooter;
		
		[self.view addSubview:self.listView];
		
		self.xyButton = [FUIButton new];
		self.xyButton.buttonColor = MMColorRed;
		self.xyButton.shadowColor = MMColorShadowRed;
		self.xyButton.shadowHeight = 3.0f;
		self.xyButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
		[self.xyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.xyButton setTitle:@"我要许愿" forState:UIControlStateNormal];
		[self.xyButton addTarget:self action:@selector(xyPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.xyButton];
		
		self.ydVC = [YuanDetailViewController new];
		self.ydVC.delegate = self;
	}
	return self;
}

-(void)queryTheList:(Boolean)isHead{
	if (isHead) {
		self.nowPage = 0;
		[self.listfooter setState:MJRefreshStateIdle];
	}else{
		self.nowPage++;
	}
	AVQuery *query = [AVQuery queryWithClassName:@"WishTree"];
	query.limit = self.pageEleCount;
	query.skip = self.nowPage * self.pageEleCount;
	[query orderByDescending:@"wishdate"];
	if(self.mySegment.selectedSegmentIndex == 0){
		[query whereKey:@"hidden" equalTo:@(NO)];
	}else if(self.mySegment.selectedSegmentIndex == 1){
		AVUser *currentUser = [AVUser currentUser];
		[query whereKey:@"username" equalTo:currentUser[@"username"]];
	}
	[SVProgressHUD showWithStatus:@"加载中..."];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			[SVProgressHUD dismiss];
			if (isHead) {
				self.wishArray = objects;
				[self.listView reloadData];
				[self.listView scrollsToTop];
				[self.listheader endRefreshing];
			}else {
				self.wishArray = [self.wishArray arrayByAddingObjectsFromArray:objects];
				[self.listView reloadData];
				[self.listView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
				[self.listfooter endRefreshing];
			}
			if ([objects count] < self.pageEleCount) {
				[self.listfooter endRefreshingWithNoMoreData];
			}
		} else {
			[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取失败:%@", error]];
			if (isHead) {
				self.nowPage = 0;
				self.wishArray = [NSArray array];
				[self.listView reloadData];
				[self.listView scrollsToTop];
				[self.listheader endRefreshing];
			}else {
				// nothing changes with wisharray
				self.nowPage--;
				// self.wishArray = [NSArray array];
				[self.listView reloadData];
				[self.listView scrollsToTop];
				[self.listfooter endRefreshingWithNoMoreData];
			}
		}
	}];
}

-(void)segChanged:(id)sender{
	[self.listheader beginRefreshing];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	WS(ws);
	
	[self.singleToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view.mas_left);
		make.right.mas_equalTo(ws.view.mas_right);
		make.top.mas_equalTo(ws.view.mas_top);
		make.height.mas_equalTo(44);
	}];
	
	[self.mySegment mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.singleToolbar).with.insets(UIEdgeInsetsMake(7,7,7,7));
		make.centerX.equalTo(self.singleToolbar.mas_centerX);
		make.centerY.equalTo(self.singleToolbar.mas_centerY);
	}];
	
	[self.xyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view);
		make.right.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view);
		make.height.mas_equalTo(40);
	}];
	
	[self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view.mas_left);
		make.right.mas_equalTo(ws.view.mas_right);
		make.top.mas_equalTo(self.singleToolbar.mas_bottom);
		make.bottom.mas_equalTo(self.xyButton.mas_top);
	}];
	[self segChanged:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 70.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.wishArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YWTableViewCell *cell = nil;
	static NSString *cellIdentifier = @"HuanyuanCellID";
	// Similar to UITableViewCell, but
	cell = (YWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[YWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	AVObject *item = [self.wishArray objectAtIndex:indexPath.row];
	NSDate *date = (NSDate*)item.createdAt;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//设置格式：zzz表示时区
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	//NSDate转NSString
	NSString *currentDateString = [dateFormatter stringFromDate:date];
	// Just want to test, so I hardcode the data
	cell.mainLabel.text = [NSString stringWithFormat:@"%@_%@%@",item[@"bigwish"],item[@"smallwish"],([item[@"hidden"] boolValue] == YES?@"（私密）":@"")];
	if ([item[@"anonymous"] boolValue] == YES) {
		cell.dateLabel.text = [NSString stringWithFormat:@"%@ 匿名",currentDateString];
	}else{
		cell.dateLabel.text = [NSString stringWithFormat:@"%@ %@",currentDateString,[item[@"nickname"] length] > 0 ?item[@"nickname"]:item[@"username"]];
	}
	cell.numberLabel.text = [NSString stringWithFormat:@"No.%08d",[item[@"wishid"] intValue]];
	cell.moneyLabel.text = [item[@"gold"] intValue] == 0?@"":[NSString stringWithFormat:@"㉤%d",[item[@"gold"] intValue]];
	cell.praiseLabel.text = [item[@"wishcount"] intValue] == 0?@"":[NSString stringWithFormat:@"♡ %d",[item[@"wishcount"] intValue]];
	[cell.bgImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg_%d.jpg",[item[@"luck_no"] intValue]]]];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	AVObject *item = [self.wishArray objectAtIndex:indexPath.row];
	self.ydVC.myWish = item;
	[APPALL.myKGModal showWithContentViewController:self.ydVC];
}

-(void)xyPressed:(id)sender{
	if(![tooles getnickname]){
		UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请先登录" message:@"许愿前，请在个人主页登录并完善您的个人信息。" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
		[vc addAction:cancelAction];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self presentViewController:vc animated:YES completion:nil];
		});
		return;
	}
	YuanwangViewController *vc = [YuanwangViewController new];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void)ydClickIndex:(NSInteger)buttonIndex {
	NSLog(@"ydCLickllll:%ld",buttonIndex);
	if (buttonIndex == 1) {// 编辑
		YwEditVController *vc = [YwEditVController new];
		[vc setWishItem:self.ydVC.myWish];
		[self.navigationController pushViewController:vc animated:YES];
	}else if (buttonIndex == 2) {//祝福ta
		[self segChanged:nil];
	}
}

@end
