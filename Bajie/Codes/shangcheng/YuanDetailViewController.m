//
//  YuanDetailViewController.m
//  WishTree
//
//  Created by MingmingSun on 2018/2/25.
//  Copyright © 2018年 Sunmingming. All rights reserved.
//

#import "YuanDetailViewController.h"
#import "FotaiVController.h"
#import <SVProgressHUD.h>
#import "AppDelegate.h"
#import "tooles.h"
#import <FlatUIKit.h>
#import <Masonry.h>

@interface YuanDetailViewController ()

@property(nonatomic,strong) FotaiVController *foViewController;
@property(nonatomic,assign) CGFloat fotaiWidth;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UITextView *contentField;
@property(nonatomic,strong) UILabel *dateLabel;
@property(nonatomic,strong) UILabel *moneyLabel;

@end

@implementation YuanDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.view.frame = CGRectMake(0, 0, kDeviceWidth * 0.875, KDeviceHeight * 0.75);
		self.view.backgroundColor = MMColorOrange;
		
		self.fotaiWidth = kDeviceWidth * 0.875;
		self.foViewController = [[FotaiVController alloc] initWithFoName:@""
																													andXiangID:0
																												andVoterName:@""
																														andKunit:self.fotaiWidth];
		[self.view addSubview:self.foViewController.view];
		
		self.titleLabel = [UILabel new];
		self.titleLabel.textColor = [UIColor blackColor];
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
		[self.view addSubview:self.titleLabel];
		
		self.dateLabel = [UILabel new];
		self.dateLabel.textColor = [UIColor grayColor];
		self.dateLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		self.dateLabel.textAlignment = NSTextAlignmentRight;
		[self.view addSubview:self.dateLabel];
		
		self.moneyLabel = [UILabel new];
		self.moneyLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
		self.moneyLabel.textAlignment = NSTextAlignmentLeft;
		[self.view addSubview:self.moneyLabel];
		
		self.contentField = [UITextView new];
		self.contentField.backgroundColor = [UIColor clearColor];
		self.contentField.font = [UIFont fontWithName:@"Arial" size:16.0f];
		self.contentField.textColor = [UIColor darkGrayColor];
		self.contentField.editable = NO;
		self.contentField.selectable = NO;
		[self.view addSubview:self.contentField];
		
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self.foViewController setFoName:self.myWish[@"foname"]];
	[self.foViewController setXiangID:[self.myWish[@"xiangid"] intValue]];
	[self.foViewController setVoterName:self.myWish[@"username"]];
	
	self.titleLabel.text = self.myWish[@"title"];
	self.contentField.text = self.myWish[@"content"];
	
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
		make.top.mas_equalTo(ws.view.mas_top).with.offset(ws.fotaiWidth * 468/566);
		make.height.mas_equalTo(20);
	}];
	
	[self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(ws.view);
		make.height.mas_equalTo(20);
	}];
	
	[self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.bottom.mas_equalTo(ws.view);
		make.height.mas_equalTo(20);
	}];
	
	[self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleLabel.mas_left);
		make.right.mas_equalTo(self.titleLabel.mas_right);
		make.top.mas_equalTo(self.titleLabel.mas_bottom);
		make.bottom.mas_equalTo(self.dateLabel.mas_top);
	}];
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

@end

