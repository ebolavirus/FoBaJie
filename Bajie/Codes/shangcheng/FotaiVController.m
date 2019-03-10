//
//  FotaiVController.m
//  Bajie
//
//  Created by MingmingSun on 2019/3/10.
//  Copyright © 2019 Sunmingming. All rights reserved.
//

#import "FotaiVController.h"
#import <Masonry.h>

@interface FotaiVController ()

@property(nonatomic,strong) UIImageView *LUImageView;
@property(nonatomic,strong) UIImageView *RUImageView;
@property(nonatomic,strong) UIImageView *LFireImageView;
@property(nonatomic,strong) UIImageView *RFireImageView;
@property(nonatomic,strong) UIImageView *FoImageView;
@property(nonatomic,strong) UIImageView *LDImageView;
@property(nonatomic,strong) UIImageView *RDImageView;
@property(nonatomic,strong) UIImageView *FlowerImageView;

@end

@implementation FotaiVController

- (id)initWithFoID:(int)aFoID andXiangID:(int)aXiangID
{
	self = [super init];
	if (self) {
		CGFloat kunit = kDeviceWidth;
		
		self.view.frame = CGRectMake(0, 0, kunit, kunit * 468/566);
		self.view.backgroundColor = [UIColor clearColor];
		
		self.LUImageView = [UIImageView new];
		self.LUImageView.image = [UIImage imageNamed:@"fo_bg_tl.jpg"];
		self.LUImageView.frame = CGRectMake(0, 0, kunit * 122/566, kunit * 309/566);
		[self.view addSubview:self.LUImageView];
		
		self.RUImageView = [UIImageView new];
		self.RUImageView.image = [UIImage imageNamed:@"fo_bg_tr.jpg"];
		self.RUImageView.frame = CGRectMake(kunit * 444/566, 0, kunit * 122/566, kunit * 309/566);
		[self.view addSubview:self.RUImageView];
		
		self.LFireImageView = [UIImageView new];
		self.LFireImageView.image = [UIImage imageNamed:@"fo_gd_l.gif"];
		self.LFireImageView.frame = CGRectMake(kunit * 122/566, 0, kunit * 37/566, kunit * 309/566);
		[self.view addSubview:self.LFireImageView];
		
		self.RFireImageView = [UIImageView new];
		self.RFireImageView.image = [UIImage imageNamed:@"fo_gd_r.gif"];
		self.RFireImageView.frame = CGRectMake(kunit * 407/566, 0, kunit * 37/566, kunit * 309/566);
		[self.view addSubview:self.RFireImageView];
		
		self.FoImageView = [UIImageView new];
		self.FoImageView.image = [UIImage imageNamed:@"fo_fx_ysf.jpg"];
		self.FoImageView.frame = CGRectMake(kunit * 159/566, 0, kunit * 248/566, kunit * 309/566);
		[self.view addSubview:self.FoImageView];
		
		self.LDImageView = [UIImageView new];
		self.LDImageView.image = [UIImage imageNamed:@"fo_bg_bl.jpg"];
		self.LDImageView.frame = CGRectMake(0, kunit * 309/566, kunit * 224/566, kunit * 159/566);
		[self.view addSubview:self.LDImageView];
		
		self.RDImageView = [UIImageView new];
		self.RDImageView.image = [UIImage imageNamed:@"fo_bg_br.jpg"];
		self.RDImageView.frame = CGRectMake(kunit * 342/566, kunit * 309/566, kunit * 224/566, kunit * 159/566);
		[self.view addSubview:self.RDImageView];
		
		self.FlowerImageView = [UIImageView new];
		self.FlowerImageView.image = [UIImage imageNamed:@"fo_gp_flower.gif"];
		self.FlowerImageView.frame = CGRectMake(kunit * 224/566, kunit * 309/566, kunit * 118/566, kunit * 159/566);
		[self.view addSubview:self.FlowerImageView];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	WS(ws);
	
	[self.LUImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view);
		make.top.mas_equalTo(ws.view);
	}];
	
	[self.LFireImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.LUImageView.mas_right);
		make.top.mas_equalTo(ws.view);
	}];
	
	[self.FoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(ws.view);
		make.top.mas_equalTo(ws.view);
	}];
	
	[self.RUImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(ws.view);
		make.top.mas_equalTo(ws.view);
	}];
	
	[self.RFireImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(ws.RUImageView.mas_left);
		make.top.mas_equalTo(ws.view);
	}];
	
	[self.LDImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view);
	}];
	
	[self.RDImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view);
	}];
	
	[self.FlowerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(ws.view);
		make.bottom.mas_equalTo(ws.view);
	}];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
