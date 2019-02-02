//
//  XYBGViewController.h
//  WishTree
//
//  Created by MingmingSun on 2018/2/26.
//  Copyright © 2018年 Sunmingming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYBGDelegate <NSObject>

- (void)bgIndex:(NSInteger)bgid;

@end

@interface XYBGViewController : UIViewController

@property (nonatomic, assign) id<XYBGDelegate> delegate;

@end
