//
//  SMMNav.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/9/9.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "SMMNav.h"
#import <FlatUIKit.h>
#import "AppDelegate.h"

@implementation SMMNav

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationBar configureFlatNavigationBarWithColor:MMColorOrange];
        self.navigationBar.barTintColor = [UIColor blackColor];
        self.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationBar.tintColor = [UIColor whiteColor];
        return self;
    }
    return self;
}

@end
