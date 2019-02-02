//
//  YuanwangViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/9/25.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "YwEditVController.h"
#import "XYBGViewController.h"
#import "NIDropDown.h"
#import <FlatUIKit.h>
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import <SVProgressHUD.h>
#import "AppDelegate.h"
#import "MOFSPickerManager.h"
#import <Masonry.h>
#import "tooles.h"

@interface YwEditVController ()<NIDropDownDelegate,UITextViewDelegate,XYBGDelegate,VCIAPDelegate>
{
	NIDropDown *dropDown;
}

-(void)rel;

@property(nonatomic,strong) NSString *bigwish;
@property(nonatomic,strong) NSString *smallwish;
@property(nonatomic,assign) NSInteger luck_no;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) FUIButton *kindButton;
@property(nonatomic,strong) UIButton *bgButton;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) UITextView *contentField;
@property(nonatomic,strong) FUIButton *xyButton;
@property(nonatomic,strong) FUISwitch *hiddenSwitch;
@property(nonatomic,strong) UILabel *hiddenText;
@property(nonatomic,strong) FUISwitch *anonySwitch;
@property(nonatomic,strong) UILabel *anonyText;
@property(nonatomic,strong) UIButton *moneyButton;

@property(nonatomic,strong) AVObject *myWish;

@end
//OK,finally the last xib file to remove.
@implementation YwEditVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"愿望";
		self.view.backgroundColor = MMColorYellow;
		
		self.bigwish = @"吉祥运气";
		self.smallwish = @"心想事成";
		self.luck_no = 0;
		
		self.titleLabel = [UILabel new];
		self.titleLabel.numberOfLines = 0;
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.text = @"在此写下您的愿望，许愿树祝您梦想成真！";
		self.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		[self.view addSubview:self.titleLabel];
		
		self.kindButton = [FUIButton new];
		self.kindButton.buttonColor = MMColorRed;
		self.kindButton.shadowColor = MMColorShadowRed;
		self.kindButton.shadowHeight = 3.0f;
		self.kindButton.cornerRadius = 6.0f;
		self.kindButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
		[self.kindButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.kindButton setTitle:@"求：吉祥运气-心想事成" forState:UIControlStateNormal];
		[self.kindButton addTarget:self action:@selector(kindPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.kindButton];
		
		self.contentField = [UITextView new];
		self.contentField.backgroundColor = [UIColor clearColor];
		self.contentField.font = [UIFont fontWithName:@"Arial" size:16.0f];
		self.contentField.returnKeyType = UIReturnKeyDone;
		self.contentField.delegate = self;
		self.contentField.textColor = [UIColor blackColor];
		self.contentField.placeholder = @"写下您的心愿吧！限制200个字哦。";
		self.contentField.placeholderColor = [UIColor grayColor];
		self.contentField.layer.borderWidth = 2.0f;
		self.contentField.layer.borderColor = MMColorBlack.CGColor;
		[self.view addSubview:self.contentField];
		
		self.moneyLabel = [UILabel new];
		self.moneyLabel.numberOfLines = 0;
		self.moneyLabel.font = [UIFont boldFlatFontOfSize:16];
		self.moneyLabel.text = [NSString stringWithFormat:@"为让愿望更快实现，我愿捐献：\n供奉佛前油灯。\n(捐献越多，您的许愿在许愿树中越靠前。)\n  ————%@",[tooles getnickname]];
		[self.view addSubview:self.moneyLabel];
		
		self.moneyButton = [UIButton new];
		[self.moneyButton setBackgroundColor:MMColorGrey];
		[self.moneyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		self.moneyButton.layer.borderWidth = 2.0f;
		self.moneyButton.layer.borderColor = MMColorBlack.CGColor;
		self.moneyButton.layer.cornerRadius = 3.0f;
		[self.moneyButton setTitle:@"0功德" forState:UIControlStateNormal];
		[self.moneyButton addTarget:self action:@selector(moneyPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.moneyButton];
		
		self.bgButton = [UIButton new];
		[self.bgButton setTitle:@"选择许愿卡背景" forState:UIControlStateNormal];
		[self.bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[self.bgButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg_%li.jpg",self.luck_no]] forState:UIControlStateNormal];
		[self.bgButton addTarget:self action:@selector(bgPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.bgButton];
		
		self.xyButton = [FUIButton new];
		self.xyButton.buttonColor = MMColorRed;
		self.xyButton.shadowColor = MMColorShadowRed;
		self.xyButton.shadowHeight = 3.0f;
		self.xyButton.cornerRadius = 6.0f;
		self.xyButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
		[self.xyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.xyButton setTitle:@"提  交  许  愿" forState:UIControlStateNormal];
		[self.xyButton addTarget:self action:@selector(xyPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.xyButton];
		
		self.hiddenSwitch = [FUISwitch new];
		self.hiddenSwitch.onColor = MMColorYellow;
		self.hiddenSwitch.offColor = MMColorRed;
		self.hiddenSwitch.onBackgroundColor = MMColorShadowRed;
		self.hiddenSwitch.offBackgroundColor = MMColorShadowRed;
		self.hiddenSwitch.on = NO;
		[self.view addSubview:self.hiddenSwitch];
		
		self.hiddenText = [UILabel new];
		self.hiddenText.numberOfLines = 0;
		self.hiddenText.text = @"设置私密，仅自己可见。";
		self.hiddenText.font = [UIFont fontWithName:@"Arial" size:14.0f];
		[self.view addSubview:self.hiddenText];
		
		self.anonySwitch = [FUISwitch new];
		self.anonySwitch.onColor = MMColorYellow;
		self.anonySwitch.offColor = MMColorRed;
		self.anonySwitch.onBackgroundColor = MMColorShadowRed;
		self.anonySwitch.offBackgroundColor = MMColorShadowRed;
		self.anonySwitch.on = NO;
		[self.view addSubview:self.anonySwitch];
		
		self.anonyText = [UILabel new];
		self.anonyText.numberOfLines = 0;
		self.anonyText.text = @"设置匿名，不显示自己名字。";
		self.anonyText.font = [UIFont fontWithName:@"Arial" size:14.0f];
		[self.view addSubview:self.anonyText];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	WS(ws);
	
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view.mas_left);
		make.right.mas_equalTo(ws.view.mas_right);
		make.top.mas_equalTo(ws.view).with.offset(10);
		make.height.mas_equalTo(20);
	}];
	
	[self.kindButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view).with.offset(20);
		make.right.mas_equalTo(ws.view).with.offset(-20);
		make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(10);
		make.height.mas_equalTo(40);
	}];
	
	[self.anonySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view).with.offset(20);
		make.width.mas_equalTo(60);
		make.bottom.mas_equalTo(ws.view).with.offset(-20);
		make.height.mas_equalTo(20);
	}];
	
	[self.anonyText mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.anonySwitch.mas_right).with.offset(10);
		make.right.mas_equalTo(ws.view).with.offset(-20);
		make.bottom.mas_equalTo(ws.view).with.offset(-20);
		make.height.mas_equalTo(20);
	}];
	
	[self.hiddenSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view).with.offset(20);
		make.width.mas_equalTo(60);
		make.bottom.mas_equalTo(ws.anonySwitch.mas_top).with.offset(-10);
		make.height.mas_equalTo(20);
	}];
	
	[self.hiddenText mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.hiddenSwitch.mas_right).with.offset(10);
		make.right.mas_equalTo(ws.view).with.offset(-20);
		make.bottom.mas_equalTo(ws.anonyText.mas_top).with.offset(-10);
		make.height.mas_equalTo(20);
	}];
	
	[self.xyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view).with.offset(20);
		make.right.mas_equalTo(ws.view).with.offset(-20);
		make.bottom.mas_equalTo(self.hiddenSwitch.mas_top).with.offset(-10);
		make.height.mas_equalTo(40);
	}];
	
	[self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view);
		make.right.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(self.xyButton.mas_top).with.offset(-10);
		make.height.mas_equalTo(60);
	}];
	
	[self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(self.bgButton.mas_top).with.offset(-10);
		make.height.mas_equalTo(80);
	}];
	
	[self.moneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(100, 20));
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.top.mas_equalTo(self.moneyLabel.mas_top);
	}];
	
	[self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.top.mas_equalTo(self.kindButton.mas_bottom).with.offset(10);
		make.bottom.mas_equalTo(self.moneyLabel.mas_top).with.offset(-10);
	}];
}

-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	if([text isEqualToString:@"\n"]){
		[textView resignFirstResponder];
		return NO;
	}
	return YES;
}

-(void)xyPressed:(id)sender{
	if(!self.contentField.text.length){
		[SVProgressHUD setMinimumDismissTimeInterval:2.0f];
		[SVProgressHUD showInfoWithStatus:@"愿望不能为空，否则空欢喜一场！"];
		return;
	}
	if(!self.myWish) {
		return;
	}
	if([[self.moneyButton titleForState:UIControlStateNormal] isEqualToString:@"0功德"]){
		// [self VCIAPSucceed:@""];
		NSString *helpStr = @"二次编辑中如果不进行捐献，则许愿内容无法进行修改。";
		UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"无法修改" message:helpStr preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
		UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"返回上一页" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
			[self.navigationController popViewControllerAnimated:YES];
		}];
		[vc addAction:backAction];
		[vc addAction:cancelAction];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self presentViewController:vc animated:YES completion:nil];
		});
		return;
	}
	NSString *moneyStr = [[self.moneyButton titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@"功德" withString:@"元"];
	UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"许愿" message:[NSString stringWithFormat:@"本次许愿需花费%@",moneyStr] preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	UIAlertAction *ok1Action = [UIAlertAction actionWithTitle:@"确认"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[SVProgressHUD showWithStatus:@"请稍候..."];
		APPALL.myIAPDelegate = self;
		NSString *iapID = [tooles getIAPIDByPriceStr:moneyStr payKind:EPayHY];
		[APPALL startToIAP:iapID];
	}];
	[vc addAction:ok1Action];
	[vc addAction:cancelAction];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentViewController:vc animated:YES completion:nil];
	});
}

-(void)moneyPressed:(id)sender {
	//8,18,50,88,138,198,268,588
	NSArray * arr = [NSArray arrayWithObjects:@"8功德",@"18功德",@"50功德",@"88功德",@"138功德",@"198功德",@"268功德",@"588功德",nil];
	if(dropDown == nil) {
		CGFloat f = 225;
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
	NSLog(@"%@", self.moneyButton.titleLabel.text);
}

-(void)rel{
	//    [dropDown release];
	dropDown = nil;
}

-(void)kindPressed:(id)sender {
	[[MOFSPickerManager shareManger] showMOFSWishTypePickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *bwish, NSString *swish) {
		self.bigwish = bwish;
		self.smallwish = swish;
		[self.kindButton setTitle:[NSString stringWithFormat:@"求：%@-%@",self.bigwish,self.smallwish] forState:UIControlStateNormal];
	} cancelBlock:^{
		
	}];
}

-(void)bgPressed:(id)sender {
	XYBGViewController *vc = [XYBGViewController new];
	vc.delegate = self;
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)bgIndex:(NSInteger)bgid {
	self.luck_no = bgid;
	[self.bgButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg_%li.jpg",self.luck_no]] forState:UIControlStateNormal];
}

-(void)setWishItem:(AVObject*)aItem {
	self.myWish = aItem;
	self.bigwish = self.myWish[@"bigwish"];
	self.smallwish = self.myWish[@"smallwish"];
	self.luck_no = [self.myWish[@"luck_no"] intValue];
	[self.bgButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg_%li.jpg",self.luck_no]] forState:UIControlStateNormal];
	[self.kindButton setTitle:[NSString stringWithFormat:@"求：%@-%@",self.bigwish,self.smallwish] forState:UIControlStateNormal];
	self.contentField.text = self.myWish[@"content"];
	int goldNum = [self.myWish[@"gold"] intValue];
	[self.moneyButton setTitle:[NSString stringWithFormat:@"%d功德",goldNum] forState:UIControlStateNormal];
	if (goldNum > 0) {
		self.moneyButton.enabled = NO;
	}else{
		self.moneyButton.enabled = YES;
	}
	self.hiddenSwitch.on = [self.myWish[@"hidden"] boolValue];
	self.anonySwitch.on = [self.myWish[@"anonymous"] boolValue];
}

- (void)VCIAPSucceed:(NSString*)aSucc{
	[SVProgressHUD dismiss];
	[self.myWish setObject:self.contentField.text forKey:@"content"];
	[self.myWish setObject:self.bigwish forKey:@"bigwish"];
	[self.myWish setObject:self.smallwish forKey:@"smallwish"];
	NSString *goldstr = [self.moneyButton titleForState:UIControlStateNormal];
	int goldnum = [[goldstr substringToIndex:goldstr.length - 1] intValue];
	[self.myWish setObject:[NSNumber numberWithInt:goldnum] forKey:@"gold"];
	[self.myWish setObject:[NSNumber numberWithInteger:self.luck_no] forKey:@"luck_no"];
	NSDate *saveDate = [NSDate dateWithTimeIntervalSinceNow:goldnum * 86400];
	[self.myWish setObject:saveDate forKey:@"wishdate"];
	[self.myWish setObject:@(self.hiddenSwitch.isOn) forKey:@"hidden"];
	[self.myWish setObject:@(self.anonySwitch.isOn) forKey:@"anonymous"];
	[self.myWish saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
		if(succeeded){
			UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"许愿成功" message:@"恭喜您许愿成功！" preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
				[self.navigationController popViewControllerAnimated:YES];
			}];
			[vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
		}else{
			[SVProgressHUD showErrorWithStatus:@"许愿失败，请查看您的而网络。"];
		}
	}];
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

