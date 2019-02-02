//
//  tooles.m
//  huoche
//
//  Created by kan xu on 11-1-22.
//  Copyright 2011 paduu. All rights reserved.
//

#import "tooles.h"
#import "AppDelegate.h"

@implementation tooles

+(NSString*)getIAPIDByPriceStr:(NSString*)aPrice payKind:(EPayKind)aPayKind{
    switch (aPayKind) {
        case EPayHY:{
            //8,18,50,88,138,198,268,588
            if([aPrice hasPrefix:@"88"])
                return kIAPXY_88;
            else if([aPrice hasPrefix:@"8"])
                return kIAPXY_8;
            else if([aPrice hasPrefix:@"18"])
                return kIAPXY_18;
            else if([aPrice hasPrefix:@"50"])
                return kIAPXY_50;
            else if([aPrice hasPrefix:@"138"])
                return kIAPXY_138;
            else if([aPrice hasPrefix:@"198"])
                return kIAPXY_198;
            else if([aPrice hasPrefix:@"268"])
                return kIAPXY_268;
            else if([aPrice hasPrefix:@"588"])
                return kIAPXY_588;
        }
            break;
        case EPayXH:{
            //8,98
            if([aPrice hasPrefix:@"8"])
                return kIAPXH_8;
            else if([aPrice hasPrefix:@"98"])
                return kIAPXH_98;
            else if([aPrice hasPrefix:@"198"])
                return kIAPXH_198;
        }
            break;
        case EPayFN:{
            //1,8,50,98,298
            if([aPrice hasPrefix:@"1"])
                return kIAPFN_1;
            else if([aPrice hasPrefix:@"8"])
                return kIAPFN_8;
            else if([aPrice hasPrefix:@"50"])
                return kIAPFN_50;
            else if([aPrice hasPrefix:@"98"])
                return kIAPFN_98;
            else if([aPrice hasPrefix:@"298"])
                return kIAPFN_298;
        }
            break;
        default:
            break;
    }
    return @"";
}

+(NSString*)getLabelFromIndex:(NSInteger)aIndex{
    switch (aIndex) {
        case 0:
            return @"";
        case 1:
            return @"清\n香";
        case 2:
            return @"平\n安";
        case 3:
            return @"高\n升";
        case 4:
            return @"祈\n福";
        case 5:
            return @"鸿\n运";
        case 6:
            return @"长\n寿";
        case 7:
            return @"就\n业";
        case 8:
            return @"姻\n缘";
        case 9:
            return @"求\n子";
        case 10:
            return @"去\n病";
        case 11:
            return @"学\n业";
        case 12:
            return @"圆\n满";
        default:
            return @"";
    }
}

+(BOOL)verifyInputs:(NSString*)aStr forInputType:(EInputType)aType{
    switch (aType) {
        case EInputUsername:{
            NSString *userNameRegex = @"^[A-Za-z0-9]{5,20}+$";
            NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
            return [userNamePredicate evaluateWithObject:aStr];
        }
            break;
        case EInputPassword:{
            NSString *passWordRegex = @"^[a-zA-Z0-9]{5,20}+$";
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:aStr];
        }
            break;
        default:
            return NO;
    }
    return NO;
}

+(NSString*)getnickname{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        return currentUser[@"nickname"];
    }else{
        return nil;
    }
}

+(void)addHonor:(NSString*)aHonor{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        //get the honor integer
        NSInteger aH = [[aHonor substringToIndex:aHonor.length-1] integerValue];
        [currentUser incrementKey:@"honor" byAmount:[NSNumber numberWithInteger:aH]];
        [currentUser saveInBackground];
    }else{
        //nothing
    }
}

+(NSString*)getErrorString:(NSInteger)aCode{
    switch (aCode) {
        case 200:return @"用户名为空。";
        case 201:return @"密码为空。";
        case 202:return @"用户名已经被占用。";
        case 203:return @"电子邮箱地址已经被占用。";
        case 204:return @"没有提供电子邮箱地址。";
        case 205:return @"找不到电子邮箱地址对应的用户。";
        case 206:return @"无法修改用户信息。";
        case 207:return @"不允许第三方登录。";
        case 208:return @"第三方帐号已经绑定到一个用户。";
        case 210:return @"用户名和密码不匹配。";
        case 211:return @"找不到用户。";
        case 212:return @"请提供手机号码。";
        case 213:return @"手机号码对应的用户不存在。";
        case 214:return @"手机号码已经被注册。";
        case 215:return @"未验证的手机号码。";
        case 216:return @"未验证的邮箱地址。";
        case 217:return @"无效的用户名。";
        case 218:return @"无效的密码。";
        case 219:return @"登录失败次数超过限制，请稍候再试，或者通过忘记密码重设密码。";
        default: return @"操作失败。";
    }
}

@end
