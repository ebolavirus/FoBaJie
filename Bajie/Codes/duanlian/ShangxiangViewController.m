//
//  ShangxiangViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/9/23.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "ShangxiangViewController.h"
#import <SVProgressHUD.h>
#import "LocalItem.h"
#import "XianghuoViewController.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import "tooles.h"

@interface ShangxiangViewController ()<VCIAPDelegate>

@property(nonatomic,strong) UIImageView *bgView;
@property(nonatomic,strong) UIImageView *foLightView;
@property(nonatomic,strong) UIImageView *foView;
@property(nonatomic,strong) UIImageView *smokeView;
@property(nonatomic,strong) UIImageView *stoveView;
@property(nonatomic,strong) UILabel *stoveLabel;

@property(nonatomic,strong) UIButton *gongdexiangButton;
@property(nonatomic,strong) UIImageView *xiangView;
@property(nonatomic,strong) UILabel *xiangLabel;
@property(nonatomic,strong) UIButton *stoveButton;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) NSString *moneytext;

@end

@implementation ShangxiangViewController

@synthesize smokeView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lifo_bg.png"]];
		self.bgView.contentMode = UIViewContentModeScaleToFill;
		[self.view addSubview:self.bgView];
		
		self.foLightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiuxing_lifo_circle_light"]];
		self.foLightView.contentMode = UIViewContentModeScaleAspectFit;
		[self.foLightView setFrame:CGRectMake(0, 0, kDeviceWidth/2, kDeviceWidth/2)];
		[self.view addSubview:self.foLightView];
		
		self.foView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guanyinpusa.png"]];
		self.foView.contentMode = UIViewContentModeScaleAspectFit;
		[self.foView setFrame:CGRectMake(0, 0, kDeviceWidth/2, kDeviceWidth/2)];
		[self.view addSubview:self.foView];
		
		self.stoveView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiuxing_xiang"]];
		self.stoveView.contentMode = UIViewContentModeScaleAspectFit;
		[self.view addSubview:self.stoveView];
		
		self.stoveLabel = [UILabel new];
		self.stoveLabel.text = @"点此上香";
		self.stoveLabel.textColor = [UIColor whiteColor];
		self.stoveLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		self.stoveLabel.textAlignment = NSTextAlignmentCenter;
		[self.view addSubview:self.stoveLabel];
		
		self.smokeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fotang_xiang1"]];
		self.smokeView.animationImages = @[[UIImage imageNamed:@"fotang_xiang1"],[UIImage imageNamed:@"fotang_xiang2"],[UIImage imageNamed:@"fotang_xiang3"]];
		smokeView.animationDuration = 1.0f;
		smokeView.contentMode = UIViewContentModeScaleAspectFit;
		[self.view addSubview:self.smokeView];
		
		self.xiangView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag0"]];
		[self.view addSubview:self.xiangView];
		
		self.xiangLabel = [UILabel new];
		self.xiangLabel.text = @"";
		self.xiangLabel.numberOfLines = 0;
		self.xiangLabel.textColor = [UIColor yellowColor];
		self.xiangLabel.font = [UIFont fontWithName:@"Arial" size:33.0f];
		self.xiangLabel.textAlignment = NSTextAlignmentCenter;
		[self.view addSubview:self.xiangLabel];
		
		self.gongdexiangButton = [[UIButton alloc] init];
		[self.gongdexiangButton setImage:[UIImage imageNamed:@"donate_box"] forState:UIControlStateNormal];
		[self.gongdexiangButton addTarget:self action:@selector(gongdePressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.gongdexiangButton];
		
		self.moneytext = @"8元";
		self.moneyLabel = [UILabel new];
		[self.moneyLabel setTextColor:[UIColor whiteColor]];
		[self.moneyLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
		self.moneyLabel.textAlignment = NSTextAlignmentCenter;
		self.moneyLabel.numberOfLines = 0;
		self.moneyLabel.text = @"点选功德箱\n进行捐献";
		[self.view addSubview:self.moneyLabel];
		
		self.stoveButton = [UIButton new];
		[self.stoveButton addTarget:self action:@selector(stovePressed:) forControlEvents:UIControlEventTouchUpInside];
		self.stoveButton.backgroundColor = [UIColor clearColor];
		[self.view addSubview:self.stoveButton];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	WS(ws);
	//TODO use masonry to re-frame all the subviews.
	[self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(ws.view);
	}];
	
	[self.foLightView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(kDeviceWidth*2/3);
		make.height.mas_equalTo(kDeviceWidth*2/3);
		make.centerX.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view.mas_centerY).with.offset(KDeviceHeight/11);
	}];
	
	[self.foView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(kDeviceWidth*2/3);
		make.height.mas_equalTo(kDeviceWidth*2/3);
		make.centerX.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view.mas_centerY).with.offset(KDeviceHeight/11);
	}];
	
	[self.stoveView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(kDeviceWidth/5);
		make.height.mas_equalTo(kDeviceWidth/5);
		make.centerX.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view.mas_centerY).with.offset(KDeviceHeight * 2/9);
	}];
	
	[self.stoveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(ws.view);
		make.height.mas_equalTo(30);
		make.centerX.mas_equalTo(ws.view);
		make.top.mas_equalTo(ws.stoveView.mas_bottom);
	}];
	
	[self.smokeView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(kDeviceWidth*2/3);
		make.height.mas_equalTo(kDeviceWidth*4/9);
		make.centerX.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.stoveView.mas_top);
	}];
	
	[self.xiangView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(self.xiangView.intrinsicContentSize);
		make.right.mas_equalTo(ws.view.mas_right);
		make.top.mas_equalTo(self.stoveView.mas_top);
	}];
	
	[self.xiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(self.xiangView.frame.size);
		make.centerX.mas_equalTo(self.xiangView.mas_centerX);
		make.centerY.mas_equalTo(self.xiangView.mas_centerY).with.offset(-5);
	}];
	
	[self.gongdexiangButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(self.gongdexiangButton.intrinsicContentSize);
		make.left.mas_equalTo(ws.view.mas_left);
		make.bottom.mas_equalTo(ws.view.mas_bottom);
	}];
	
	[self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(self.gongdexiangButton.intrinsicContentSize.width ,40));
		make.left.mas_equalTo(ws.view.mas_left);
		make.bottom.mas_equalTo(self.gongdexiangButton.mas_top).with.offset(-10);
	}];
	
	[self.stoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.gongdexiangButton.mas_right);
		make.right.mas_equalTo(ws.view.mas_right);
		make.bottom.mas_equalTo(ws.view.mas_bottom);
		make.top.mas_equalTo(self.stoveView.mas_top).with.offset(-self.stoveView.intrinsicContentSize.height);
	}];
	
	[self setXiangHuo];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.smokeView stopAnimating];
}

-(void)setXiangHuo{
	NSLog(@"FFFFFFFFFFFFF:%i",APPALL.myLocalItem.xiangkind);
	if(APPALL.myLocalItem.xiangkind == 0){
		self.smokeView.hidden = YES;
		self.stoveView.image = [UIImage imageNamed:@"xiuxing_xiang"];
		self.xiangView.hidden = YES;
	}else{
		double intervalTime = [[NSDate date] timeIntervalSinceReferenceDate] - [APPALL.myLocalItem.xiangtime timeIntervalSinceReferenceDate];
		//1天 6种动画， 60 * 60 * 24 / 6
		NSInteger seconds = (NSInteger)intervalTime / 14400;
		NSLog(@"seconds:%ld",(long)seconds);
		if(seconds >= 6 || seconds < 0){
			self.smokeView.hidden = YES;
			self.stoveView.image = [UIImage imageNamed:@"xiuxing_xiang"];
			self.xiangView.hidden = YES;
			return;
		}
		self.smokeView.hidden = NO;
		self.xiangView.hidden = NO;
		self.stoveView.image = [UIImage imageNamed:@"xiuxing_xiang_zengyuan"];
		self.xiangLabel.text = [tooles getLabelFromIndex:APPALL.myLocalItem.xiangkind];
		[self.smokeView startAnimating];
	}
}

-(void)gongdePressed:(id)sender{
	UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"功德箱" message:@"随缘乐助，广种福田。\n施财得福，扬善积德。\n我愿捐献：" preferredStyle:UIAlertControllerStyleAlert];
	//    vc.view.backgroundColor = [UIColor goldColor];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	UIAlertAction *ok1Action = [UIAlertAction actionWithTitle:@"1功德" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[self gongdeIAP:@"1元"];
	}];
	UIAlertAction *ok8Action = [UIAlertAction actionWithTitle:@"8功德" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[self gongdeIAP:@"8元"];
	}];
	UIAlertAction *ok50Action = [UIAlertAction actionWithTitle:@"50功德" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[self gongdeIAP:@"50元"];
	}];
	UIAlertAction *ok98Action = [UIAlertAction actionWithTitle:@"98功德" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[self gongdeIAP:@"98元"];
	}];
	UIAlertAction *ok298Action = [UIAlertAction actionWithTitle:@"298功德" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[self gongdeIAP:@"298元"];
	}];
	[vc addAction:ok1Action];
	[vc addAction:ok8Action];
	[vc addAction:ok50Action];
	[vc addAction:ok98Action];
	[vc addAction:ok298Action];
	[vc addAction:cancelAction];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentViewController:vc animated:NO completion:nil];
	});
}

-(void)gongdeIAP:(NSString*)moneyStr {
	[SVProgressHUD showWithStatus:@"请稍候..."];
	self.moneytext = moneyStr;
	APPALL.myIAPDelegate = self;
	NSString *iapID = [tooles getIAPIDByPriceStr:self.moneytext payKind:EPayFN];
	[APPALL startToIAP:iapID];
}

-(void)stovePressed:(id)sender{
	XianghuoViewController *vc = [XianghuoViewController new];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)VCIAPSucceed:(NSString*)aSucc{
	[SVProgressHUD dismiss];
//	[tooles addHonor:self.moneytext];
	UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"有求必应" message:@"捐献功德成功。\n愿施主功德圆满，前途无量！\n南无阿弥陀佛！" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
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
