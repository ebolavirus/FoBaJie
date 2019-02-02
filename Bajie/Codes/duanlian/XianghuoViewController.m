//
//  XianghuoViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/10/5.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "XianghuoViewController.h"
#import <SVProgressHUD.h>
#import "AppDelegate.h"
#import "tooles.h"
#import <Masonry.h>

@interface XianghuoViewController ()<UITableViewDelegate,UITableViewDataSource,VCIAPDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *nameArray;
@property(nonatomic,strong) NSArray *priceArray;
@property(nonatomic,strong) NSArray *voteArray;
@property(nonatomic,assign) int nowIndex;

@end

@implementation XianghuoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"选择香火种类";
		self.tableView = [UITableView new];
		self.tableView.dataSource = self;
		self.tableView.delegate = self;
		[self.view addSubview:self.tableView];
		
		self.nameArray = @[@"清香",@"平安香",@"高升香",@"祈福香",@"鸿运香",@"长寿香",@"就业香",@"姻缘高香",@"求子高香",@"去病高香",@"学业高香",@"大圆满香"];
		self.priceArray = @[@"免费",@"8功德",@"8功德",@"8功德",@"8功德",@"8功德",@"8功德",@"98功德",@"98功德",@"98功德",@"98功德",@"198功德"];
		self.voteArray = @[];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	WS(ws);
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(ws.view);
	}];
	[self getVoting];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)getVoting{
	AVQuery *query = [AVQuery queryWithClassName:@"MainTable"];
	query.limit = 100;
	[query orderByAscending:@"xiangid"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error && objects.count) {
			self.voteArray = [NSArray arrayWithArray:objects];
			[self.tableView reloadData];
		} else {
			[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取排名失败:%@", error]];
		}
	}];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 80.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return self.nameArray.count;
		default:
			return 0;
	}
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = nil;
	static NSString *inde = @"XianghuoCellID";
	cell = [tableView dequeueReusableCellWithIdentifier:inde];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"XianghuoCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	UILabel *lab1 = (UILabel*)[cell viewWithTag:1];
	UILabel *lab2 = (UILabel*)[cell viewWithTag:2];
	UILabel *lab4 = (UILabel*)[cell viewWithTag:3];
	UIImageView *headImg = (UIImageView*)[cell viewWithTag:99];
	
	lab1.text = [self.nameArray objectAtIndex:indexPath.row];
	if(self.voteArray.count){
		lab2.text = [NSString stringWithFormat:@"已有%d人上香",[self.voteArray[indexPath.row][@"xiangnum"] intValue]];
	}else{
		lab2.text = @"";
	}
	lab4.text = [self.priceArray objectAtIndex:indexPath.row];
	lab1.textColor = [UIColor blackColor];
	lab4.textColor = MMColorRed;
	if([lab4.text hasPrefix:@"免费"]){
		headImg.image = [UIImage imageNamed:@"xiang_free"];
	}else if([lab4.text hasPrefix:@"8功德"]){
		headImg.image = [UIImage imageNamed:@"xiang_middle"];
	}else if([lab4.text hasPrefix:@"98功德"]){
		headImg.image = [UIImage imageNamed:@"xiang"];
	}else if([lab4.text hasPrefix:@"198功德"]){
		headImg.image = [UIImage imageNamed:@"xiang"];
	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.row) {
		case 0:{
			AVQuery *query = [AVQuery queryWithClassName:@"MainTable"];
			[query whereKey:@"xiangid" equalTo:[NSNumber numberWithInt:1]];
			[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
				if (!error && objects.count) {
					AVObject *object = [objects firstObject];
					[object incrementKey:@"xiangnum"];
					[object saveInBackground];
				} else {
				}
			}];
			APPALL.myLocalItem.xiangkind = (int)indexPath.row + 1;
			APPALL.myLocalItem.xiangtime = [NSDate date];
			[APPALL.myLocalItem saveToDB];
			NSString *msg = [NSString stringWithFormat:@"请清香三支，持续24小时。"];
			UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请香成功" message:msg preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
				[self.navigationController popViewControllerAnimated:YES];
			}];
			[vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
		}
			break;
		default:{
			NSString *yuanStr = [[self.priceArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"功德" withString:@"元"];
			UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请香" message:[NSString stringWithFormat:@"请三支%@，需花费%@",[self.nameArray objectAtIndex:indexPath.row],yuanStr] preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
			UIAlertAction *ok1Action = [UIAlertAction actionWithTitle:@"确认"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
				[SVProgressHUD showWithStatus:@"请稍候..."];
				APPALL.myIAPDelegate = self;
				self.nowIndex = (int)indexPath.row + 1;
				NSString *iapID = [tooles getIAPIDByPriceStr:yuanStr payKind:EPayXH];
				[APPALL startToIAP:iapID];
			}];
			[vc addAction:ok1Action];
			[vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
		}
			break;
	}
}

- (void)VCIAPSucceed:(NSString*)aSucc{
	[SVProgressHUD dismiss];
	AVQuery *query = [AVQuery queryWithClassName:@"MainTable"];
	[query whereKey:@"xiangid" equalTo:[NSNumber numberWithInt:self.nowIndex]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error && objects.count) {
			AVObject *object = [objects firstObject];
			[object incrementKey:@"xiangnum"];
			[object saveInBackground];
		} else {
		}
	}];
	
	APPALL.myLocalItem.xiangkind = self.nowIndex;
	APPALL.myLocalItem.xiangtime = [NSDate date];
	[APPALL.myLocalItem saveToDB];
	NSString *msg = [NSString stringWithFormat:@"请%@三支，持续24小时。",[self.nameArray objectAtIndex:APPALL.myLocalItem.xiangkind - 1]];
	UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请香成功" message:msg preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
		[self.navigationController popViewControllerAnimated:YES];
	}];
	[vc addAction:cancelAction];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentViewController:vc animated:YES completion:nil];
	});
}

- (void)VCIAPFailed:(NSString*)aSucc{
	[SVProgressHUD dismiss];
	UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:aSucc preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
	[vc addAction:cancelAction];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentViewController:vc animated:YES completion:nil];
	});
}

@end

