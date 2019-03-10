//
//  FotaiVController.h
//  Bajie
//
//  Created by MingmingSun on 2019/3/10.
//  Copyright © 2019 Sunmingming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FotaiVController : UIViewController

- (id)initWithFoID:(int)aFoID andXiangID:(int)aXiangID;

-(void)setFoID:(int)aFoID;
-(void)setXiangAction:(int)aXiangID;

@end

NS_ASSUME_NONNULL_END
