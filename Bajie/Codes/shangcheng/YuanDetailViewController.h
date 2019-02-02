//
//  YuanDetailViewController.h
//  WishTree
//
//  Created by MingmingSun on 2018/2/25.
//  Copyright © 2018年 Sunmingming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud.h>

@protocol ydDelegate <NSObject>

- (void)ydClickIndex:(NSInteger)buttonIndex;

@end

@interface YuanDetailViewController : UIViewController

@property(nonatomic,assign) id<ydDelegate> delegate;
@property(nonatomic,strong) AVObject *myWish;

@end
