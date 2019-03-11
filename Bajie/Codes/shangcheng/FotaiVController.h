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

- (id)initWithFoID:(int)aFoID
        andXiangID:(int)aXiangID
      andVoterName:(NSString*)voterName;

@end

NS_ASSUME_NONNULL_END
