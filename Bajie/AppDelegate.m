//
//  AppDelegate.m
//  BabyBluetoothAppDemo
//
//  Created by 刘彦玮 on 15/8/1.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "AppDelegate.h"
#import "SMMNav.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import <SVProgressHUD.h>

@interface AppDelegate ()<DNSInAppPurchaseManagerDelegate>

@property(nonatomic,assign) BOOL enableIAP;
@property(nonatomic,strong) LoginViewController *loginVC;
@property(nonatomic,strong) SMMNav *loginNav;

@end

@implementation AppDelegate

@synthesize myNowAppId;
@synthesize storePayStatus;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.enableIAP = YES;
	[AVOSCloud setApplicationId:@"tSOwKL3PDeU14RDpnAbxSGlR-gzGzoHsz" clientKey:@"1vtCdlJQUYIB6GilTVpAopdb"];
	[AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
	// Override point for customization after application launch.
	NSArray *centralManagerIdentifiers = launchOptions[UIApplicationLaunchOptionsBluetoothCentralsKey];
	NSLog(@"%@",centralManagerIdentifiers);
	
	self.storePayStatus = EStoreNotReached;
	self.myNowAppId = kIAPXY_8;
	self.iapManager = [[DNSInAppPurchaseManager alloc] init];
	self.iapManager.delegate = self;
	[self setupStore];
	
	[SVProgressHUD setMinimumDismissTimeInterval:2.0f];
	
	self.myKGModal = [KGModal sharedInstance];
	[self.myKGModal setTapOutsideToDismiss:YES];
	[self.myKGModal setCloseButtonType:KGModalCloseButtonTypeNone];
	[self.myKGModal setModalBackgroundColor:[UIColor clearColor]];
	
	self.globalDBManager = [LKDBHelper getUsingLKDBHelper];
	//[self.globalDBManager dropAllTable];//清空数据库
	self.myLocalItem = [LocalItem searchSingleWithWhere:nil orderBy:nil];
	if(!self.myLocalItem)
	{
		self.myLocalItem = [[LocalItem alloc] init];
		[self.myLocalItem saveToDB];
	}
	
	self.loginVC = [LoginViewController new];
	self.loginNav = [[SMMNav alloc] initWithRootViewController:self.loginVC];
	
	RootViewController *vc = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	vc.edgesForExtendedLayout = UIRectEdgeNone;
	
	SMMNav *nav = [[SMMNav alloc] initWithRootViewController:vc];
	//    DesktopInfo
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = nav;
	[self.window makeKeyAndVisible];
	
	AVUser *currentUser = [AVUser currentUser];
	if (currentUser != nil) {
		//[self showLoginWindow];
	} else {
		[self showLoginWindow];
	}
	
	return YES;
}

#pragma mark - In-App Purchase setup
-(void)setupStore
{
	if ([self.iapManager canMakePurchases]) {
		NSLog(@"-----------can pay--------------");
		
		//Run on background thread - delegate forces callbacks on main thread.
		NSOperationQueue *background = [[NSOperationQueue alloc] init];
		__block DNSInAppPurchaseManager *blockManager = self.iapManager;
		[background addOperationWithBlock:^{
			//Gets your store items.
			[blockManager loadStoreWithIdentifiers:[NSSet setWithObjects:kIAPXY_8,kIAPXY_18,kIAPXY_50,kIAPXY_88,kIAPXY_138,kIAPXY_198,kIAPXY_268,kIAPXY_588,kIAPFN_1,kIAPFN_8,kIAPFN_50,kIAPFN_98,kIAPFN_298,kIAPXH_8,kIAPXH_98,nil]];
		}];
	} else {
		NSLog(@"-----------cannot pay--------------");
	}
}

- (void)applicationWillResignActive:(UIApplication *)application {
	NSLog(@"applicationWillResignActive");
	
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	NSLog(@"applicationWillEnterForeground");
	
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

-(void)startToIAP:(NSString*)aIAP{
	if(!self.enableIAP){
		[self.myIAPDelegate VCIAPSucceed:aIAP];
		return;
	}
	if(storePayStatus == EStoreNotReached){
		[self.myIAPDelegate VCIAPFailed:@"正在连接支付系统，请稍后再试。"];
		return;
	}
	if(storePayStatus == EStoreCanNotPay){
		[self.myIAPDelegate VCIAPFailed:@"获取支付详情失败，请检查网络后重启软件。"];
		return;
	}
	if(storePayStatus == EStoreReachFailed){
		[self.myIAPDelegate VCIAPFailed:@"连接支付系统失败，请检查网络后重启软件。"];
		return;
	}
	if(storePayStatus != EStoreCanPay)
		return;
	BOOL findProduct = NO;
	for (SKProduct *cacheProduct in self.availableProducts) {
		if([cacheProduct.productIdentifier isEqualToString:aIAP]){
			findProduct = YES;
			self.myNowAppId = cacheProduct.productIdentifier;
			
			typeof(self) __weak weakSelf = self;
			NSOperationQueue *background = [[NSOperationQueue alloc] init];
			[background addOperationWithBlock:^{
				[weakSelf.iapManager purchaseProduct:cacheProduct];
			}];
			break;
		}
	}
	if(!findProduct){
		[self.myIAPDelegate VCIAPFailed:@"未查询到该商品信息，请确保软件为正版。"];
		return;
	}
}

#pragma mark - In App Purchase Manager Delegate
-(void)productRetrievalFailed:(NSString *)errorMessage
{
	self.storePayStatus = EStoreReachFailed;
	NSLog(@"get store failed");
}

-(void)productsRetrieved:(NSArray *)products
{
	NSLog(@"--retrieved--");
	if (products) {
		self.availableProducts = products;
		if(products.count)
		{
			self.storePayStatus = EStoreCanPay;
		}
		else
		{
			self.storePayStatus = EStoreReachFailed;
		}
	} else {
		self.storePayStatus = EStoreCanNotPay;
	}
}

-(void)purchaseFailed:(NSString *)errorMessage
{
	NSLog(@"--failed-- %@",errorMessage);
	[self.myIAPDelegate VCIAPFailed:[NSString stringWithFormat:@"支付失败：%@",errorMessage]];
}

-(void)purchaseCancelled
{
	NSLog(@"--cancelled--");
	[self.myIAPDelegate VCIAPFailed:@"取消支付。"];
}

-(void)purchaseSucceeded:(NSString *)productIdentifier
{
	NSLog(@"--succeed-- %@",productIdentifier);
	if(!productIdentifier.length)
	{
		[self.myIAPDelegate VCIAPFailed:@"支付失败，支付参数错误。"];
		return;
	}
	[self.myIAPDelegate VCIAPSucceed:productIdentifier];
}

-(void)restorationSucceeded
{
	NSLog(@"--restore succeed--");
	//not used
}

-(void)restorationFailedWithError:(NSString *)errorMessage
{
	NSLog(@"--restore failed-- %@",errorMessage);
	//  not used;
}

-(void)dismissLoginWindow
{
	[self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)showLoginWindow
{
	[self.window.rootViewController presentViewController:self.loginNav animated:YES completion:nil];
}

@end
