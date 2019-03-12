//
//  YuanDetailViewController.m
//  WishTree
//
//  Created by MingmingSun on 2018/2/25.
//  Copyright © 2018年 Sunmingming. All rights reserved.
//

#import "YuanDetailViewController.h"
#import <SVProgressHUD.h>
#import "AppDelegate.h"
#import "tooles.h"
#import <FlatUIKit.h>
#import <Masonry.h>

@interface YuanDetailViewController ()

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *kindLabel;
@property(nonatomic,strong) UITextView *contentField;
@property(nonatomic,strong) UILabel *userLabel;
@property(nonatomic,strong) UILabel *dateLabel;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) FUIButton *xyButton;

@end

@implementation YuanDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.view.frame = CGRectMake(0, 0, kDeviceWidth * 0.875, KDeviceHeight * 0.75);
		self.view.backgroundColor = MMColorOrange;
		
		self.titleLabel = [UILabel new];
		self.titleLabel.text = @"许愿内容";
		self.titleLabel.textColor = [UIColor yellowColor];
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		[self.view addSubview:self.titleLabel];
		
		self.kindLabel = [UILabel new];
		self.kindLabel.textAlignment = NSTextAlignmentCenter;
		self.kindLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
		[self.view addSubview:self.kindLabel];
		
		self.userLabel = [UILabel new];
		self.userLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		self.userLabel.textAlignment = NSTextAlignmentRight;
		[self.view addSubview:self.userLabel];
		
		self.dateLabel = [UILabel new];
		self.dateLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		self.dateLabel.textAlignment = NSTextAlignmentRight;
		[self.view addSubview:self.dateLabel];
		
		self.moneyLabel = [UILabel new];
		self.moneyLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		self.moneyLabel.textAlignment = NSTextAlignmentRight;
		[self.view addSubview:self.moneyLabel];
		
		self.contentField = [UITextView new];
		self.contentField.backgroundColor = [UIColor clearColor];
		self.contentField.font = [UIFont fontWithName:@"Arial" size:16.0f];
		self.contentField.textColor = [UIColor yellowColor];
		self.contentField.editable = NO;
		self.contentField.selectable = NO;
		[self.view addSubview:self.contentField];
		
		self.xyButton = [FUIButton new];
		self.xyButton.buttonColor = MMColorRed;
		self.xyButton.shadowColor = MMColorShadowRed;
		self.xyButton.shadowHeight = 3.0f;
		self.xyButton.cornerRadius = 6.0f;
		self.xyButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
		[self.xyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.xyButton setTitle:@"关闭" forState:UIControlStateNormal];
		[self.xyButton addTarget:self action:@selector(xyPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.xyButton];
		
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	/*
	 @property(nonatomic,strong) UILabel *kindLabel;
	 @property(nonatomic,strong) UITextView *contentField;
	 @property(nonatomic,strong) UILabel *userLabel;
	 @property(nonatomic,strong) UILabel *dateLabel;
	 @property(nonatomic,strong) UILabel *moneyLabel;
	 */
	self.kindLabel.text = [NSString stringWithFormat:@"%@_%@",self.myWish[@"bigwish"],self.myWish[@"smallwish"]];
	self.contentField.text = self.myWish[@"content"];
	
	if ([self.myWish[@"anonymous"] boolValue] == YES) {
		self.userLabel.text = @"匿名";
	}else{
		self.userLabel.text = [self.myWish[@"nickname"] length] > 0 ?self.myWish[@"nickname"]:self.myWish[@"username"];
	}
	
	NSDate *date = (NSDate*)self.myWish.createdAt;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	self.dateLabel.text = [dateFormatter stringFromDate:date];
	self.moneyLabel.text = [NSString stringWithFormat:@"㉤%d",[self.myWish[@"gold"] intValue]];
	if([self.moneyLabel.text isEqualToString:@"㉤0"]) {
		self.moneyLabel.hidden = YES;
	} else {
		self.moneyLabel.hidden = NO;
	}
	
	WS(ws);
	
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view.mas_left).with.offset(10);
		make.right.mas_equalTo(ws.view.mas_right).with.offset(-10);
		make.top.mas_equalTo(ws.view.mas_top).with.offset(10);
		make.height.mas_equalTo(20);
	}];
	
	[self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(10);
		make.height.mas_equalTo(20);
	}];
	
	[self.xyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view.mas_centerX).with.offset(2);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(ws.view).with.offset(-10);
		make.height.mas_equalTo(40);
	}];
	
	[self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(self.xyButton.mas_top).with.offset(-10);
		make.height.mas_equalTo(20);
	}];
	
	[self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(self.moneyLabel.mas_top).with.offset(-5);
		make.height.mas_equalTo(20);
	}];
	
	[self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(self.dateLabel.mas_top).with.offset(-5);
		make.height.mas_equalTo(20);
	}];
	
	[self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.top.mas_equalTo(self.kindLabel.mas_bottom).with.offset(10);
		make.bottom.mas_equalTo(self.userLabel.mas_top).with.offset(-10);
	}];
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)xyPressed:(id)sender{
	[APPALL.myKGModal hideAnimated:YES];
}

@end

