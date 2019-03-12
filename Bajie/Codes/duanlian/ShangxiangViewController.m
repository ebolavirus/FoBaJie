//
//  ShangxiangViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/9/23.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "ShangxiangViewController.h"
#import "NIDropDown.h"
#import <SVProgressHUD.h>
#import "LocalItem.h"
#import "XianghuoViewController.h"
#import "FotaiVController.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import "tooles.h"

@interface ShangxiangViewController ()<NIDropDownDelegate,VCIAPDelegate>{
	NIDropDown *dropDown;
}

-(void)rel;

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
@property(nonatomic,strong) UIButton *moneyButton;
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
		self.moneyButton = [UIButton new];
		[self.moneyButton setBackgroundColor:MMColorYellow];
		[self.moneyButton setTitleColor:MMColorBlack forState:UIControlStateNormal];
		self.moneyButton.layer.borderWidth = 2.0f;
		self.moneyButton.layer.borderColor = MMColorBlack.CGColor;
		self.moneyButton.layer.cornerRadius = 3.0f;
		[self.moneyButton setTitle:@"8功德" forState:UIControlStateNormal];
		[self.moneyButton addTarget:self action:@selector(moneyPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.moneyButton];
		
		self.stoveButton = [UIButton new];
		[self.stoveButton addTarget:self action:@selector(stovePressed:) forControlEvents:UIControlEventTouchUpInside];
		self.stoveButton.backgroundColor = [UIColor clearColor];
		[self.view addSubview:self.stoveButton];
		
		FotaiVController *testVC = [[FotaiVController alloc] initWithFoID:9 andXiangID:0 andVoterName:@""];
		[self.view addSubview:testVC.view];
		
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
	
	[self.moneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(self.gongdexiangButton.intrinsicContentSize.width ,20));
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

-(void)moneyPressed:(id)sender {
	NSArray * arr = [NSArray arrayWithObjects:@"1功德",@"8功德",@"50功德",@"98功德",@"298功德",nil];
	if(dropDown == nil) {
		CGFloat f = 200;
		dropDown = [[NIDropDown alloc] showDropDown:sender :&f :arr :nil :@"down"];
		dropDown.delegate = self;
	}
	else {
		[dropDown hideDropDown:sender];
		[self rel];
	}
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
	[self rel];
	self.moneytext = [self.moneyButton.titleLabel.text stringByReplacingOccurrencesOfString:@"功德" withString:@"元"];
	NSLog(@"%@", self.moneytext);
}

-(void)rel{
	//    [dropDown release];
	dropDown = nil;
}

-(void)gongdePressed:(id)sender{
	UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"功德箱" message:[NSString stringWithFormat:@"随缘乐助，广种福田。\n功德：%@",self.moneytext] preferredStyle:UIAlertControllerStyleAlert];
	//    vc.view.backgroundColor = [UIColor goldColor];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	UIAlertAction *ok1Action = [UIAlertAction actionWithTitle:@"确认"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[SVProgressHUD showWithStatus:@"请稍候..."];
		APPALL.myIAPDelegate = self;
		NSString *iapID = [tooles getIAPIDByPriceStr:self.moneytext payKind:EPayFN];
		[APPALL startToIAP:iapID];
	}];
	[vc addAction:ok1Action];
	[vc addAction:cancelAction];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentViewController:vc animated:YES completion:nil];
	});
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
