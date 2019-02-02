//
//  AppDelegate.h
//  BlueTDevice
//
//  Created by MingmingSun on 16/7/17.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KGModal.h>
#import <SoundManager.h>
#import "LocalItem.h"
#import <LKDBHelper.h>
#import <AVOSCloud.h>
#import <DNSInAppPurchaseManager.h>

typedef enum {
	EStoreNotReached = 0,
	EStoreCanPay,
	EStoreCanNotPay,
	EStoreReachFailed,
}EReachedTag;

static NSString * const kIAPXY_8 = @"xxuyuan_0";
static NSString * const kIAPXY_18 = @"xxuyuan_2";
static NSString * const kIAPXY_50 = @"xxuyuan_3";
static NSString * const kIAPXY_88 = @"xxuyuan_4";
static NSString * const kIAPXY_138 = @"xxuyuan_5";
static NSString * const kIAPXY_198 = @"xxuyuan_6";
static NSString * const kIAPXY_268 = @"xxuyuan_7";
static NSString * const kIAPXY_588 = @"xxuyuan_8";

static NSString * const kIAPFN_1 = @"xfeng_1";
static NSString * const kIAPFN_8 = @"xfeng_2";
static NSString * const kIAPFN_50 = @"xfeng_3";
static NSString * const kIAPFN_98 = @"xfeng_4";
static NSString * const kIAPFN_298 = @"xfeng_5";

static NSString * const kIAPXH_8 = @"xxiang_1";
static NSString * const kIAPXH_98 = @"xxiang_2";
static NSString * const kIAPXH_198 = @"xxiang_3";

@protocol VCIAPDelegate<NSObject>
@optional
- (void)VCIAPSucceed:(NSString*)aSucc;
- (void)VCIAPFailed:(NSString*)aSucc;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) DNSInAppPurchaseManager *iapManager;
@property (nonatomic, strong) NSArray *availableProducts;
@property (nonatomic, strong) NSString *myNowAppId;
@property (nonatomic, assign) int storePayStatus;

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong) KGModal *myKGModal;
@property(nonatomic,strong) SoundManager *mySoundManager;

@property(strong,nonatomic) LKDBHelper* globalDBManager;
@property (strong, nonatomic) LocalItem *myLocalItem;

@property(nonatomic,assign) id<VCIAPDelegate> myIAPDelegate;
-(void)startToIAP:(NSString*)aIAP;

-(void)dismissLoginWindow;
-(void)showLoginWindow;

@end

