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

@property(nonatomic,strong) UIImageView *VoterBgImageView;
@property(nonatomic,strong) UILabel *VoterNameLabel;

@end

@implementation FotaiVController

- (id)initWithFoID:(int)aFoID
        andXiangID:(int)aXiangID
      andVoterName:(NSString*)voterName
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
		self.FoImageView.image = [UIImage imageNamed:[self getPicNameByFoName:10]];
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
        
        self.VoterBgImageView = [UIImageView new];
        self.VoterBgImageView.image = [UIImage imageNamed:@"shaoxiang_xm.jpg"];
        self.VoterBgImageView.frame = CGRectMake(kunit / 6, kunit * 421/ 566, kunit * 2/3, kunit / 18);
        [self.view addSubview:self.VoterBgImageView];
        
        self.VoterNameLabel = [UILabel new];
        self.VoterNameLabel.text = @"烧香人: 埃博拉病毒埃博拉病毒";
        self.VoterNameLabel.textAlignment = NSTextAlignmentCenter;
        self.VoterNameLabel.font = [UIFont flatFontOfSize:kunit/25];
        self.VoterNameLabel.frame = self.VoterBgImageView.frame;
        [self.view addSubview:self.VoterNameLabel];
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

- (NSString*)getPicNameByFoName:(int)aFoID {
    switch (aFoID) {
        case 0: //药师佛
            return @"fo_fx_ysf.jpg";
        case 1: //释迦牟尼佛
            return @"3-131214154509137.jpg";
        case 2: //阿弥陀佛
            return @"19-13121416204VY.jpg";
        case 3: //普贤菩萨
            return @"19-131214162P0111.jpg";
        case 4: //文殊师利菩萨
            return @"19-131214162925U5.jpg";
        case 5: //观世音菩萨
            return @"19-1312141630344c.jpg";
        case 6: //地藏王菩萨
            return @"19-131214163130R9.jpg";
        case 7: //弥勒尊佛
            return @"19-131214163315C9.jpg";
        case 8: //准提菩萨
            return @"19-1312141634261L.jpg";
        case 9: //大势至菩萨
            return @"19-131214163549392.jpg";
        case 10: //南无离怖如来
            return @"19-1312141F213157.jpg";
        case 11: //南无金色宝光妙行成就如来
            return @"19-1312141F402255.jpg";
        case 12: //南无拘那含牟尼佛
            return @"19-1312141F535N2.jpg";
        case 13: //南无甘露王如来
            return @"19-1312141F6162a.jpg";
        case 14: //南无广博身如来
            return @"19-1312141FH0224.jpg";
        case 15: //南无法海雷音如来
            return @"19-1312141FP92S.jpg";
        case 16: //南无宝月智严光音自在如来
            return @"19-1312141FUN45.jpg";
        case 17: //宝胜如来
            return @"19-1312141F9433a.jpg";
        case 18: //拘留孙佛
            return @"19-1312141G034S9.jpg";
        case 19: //韦驮菩萨
            return @"19-1312141G11H54.jpg";
        case 20: //毗卢遮那佛
            return @"19-1312141G2041L.jpg";
        case 21: //婆罗利胜头羯罗夜
            return @"19-1312141G243159.jpg";
        case 22: //南无无忧最胜吉祥如来
            return @"19-1312141G344J9.jpg";
        case 23: //南无尸弃佛
            return @"19-1312141G43DV.jpg";
        default:
            return @"fo_fx_ysf.jpg";
    }
}

- (NSString*)getPicNameByXiangName:(int)aFoID {
    switch (aFoID) {
        case 0: //药师佛
            return @"fo_gp_flower.gif";
        case 1: //释迦牟尼佛
            return @"3-131214154509137.jpg";
        case 2: //阿弥陀佛
            return @"19-13121416204VY.jpg";
        case 3: //普贤菩萨
            return @"19-131214162P0111.jpg";
        default:
            return @"fo_gp_flower.gif";
    }
}


/*
#pragma mark - Navigation
*/

@end
