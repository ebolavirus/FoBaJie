//
//  LoginViewController.m
//  RentCar
//
//  Created by sunmingming on 14-4-1.
//  Copyright (c) 2014年 Ebola. All rights reserved.
//

#import "LoginViewController.h"
#import "Register1ViewController.h"
#import "ForgetPWViewController.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import <FlatUIKit.h>
#import "tooles.h"
#import <SVProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewController ()

@property(nonatomic,strong) UILabel* loginBGView;
@property(nonatomic,strong) UIImageView* nameImage;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *passLabel;
@property(nonatomic,strong) UITextField *nameField;
@property(nonatomic,strong) UITextField *passField;

@property(nonatomic,strong) FUIButton *loginButton;
@property(nonatomic,strong) UIButton *forgetPassButton;
@property(nonatomic,strong) UIButton *directButton;

-(void)loginPressed:(id)sender;
-(void)forgetPassPressed:(id)sender;
-(void)directPressed:(id)sender;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"登录";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.loginBGView = [UILabel new];
        self.loginBGView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.loginBGView];
        
        self.nameImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputbg"]];
        self.nameImage.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:self.nameImage];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.text = @"账号";
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.nameLabel];
        
        self.passLabel = [UILabel new];
        self.passLabel.text = @"密码";
        self.passLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.passLabel];
        
        self.nameField = [UITextField new];
        self.nameField.keyboardType = UIKeyboardTypeDefault;
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.placeholder = @"请输入用户名";
        self.nameField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.view addSubview:self.nameField];
        
        self.passField = [UITextField new];
        self.passField.keyboardType = UIKeyboardTypeDefault;
        self.passField.secureTextEntry = YES;
        self.passField.returnKeyType = UIReturnKeyDone;
        self.passField.placeholder = @"请输入密码";
        self.passField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.passField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.view addSubview:self.passField];
        
        self.loginButton = [FUIButton new];
        self.loginButton.buttonColor = MMColorRed;
        self.loginButton.shadowColor = MMColorShadowRed;
        self.loginButton.shadowHeight = 3.0f;
        self.loginButton.cornerRadius = 6.0f;
        self.loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.loginButton];
        
        self.forgetPassButton = [UIButton new];
        [self.forgetPassButton setTitle:@"修改密码" forState:UIControlStateNormal];
        [self.forgetPassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.forgetPassButton.hidden = true;
        [self.forgetPassButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.forgetPassButton addTarget:self action:@selector(forgetPassPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.forgetPassButton];
        
        self.directButton = [UIButton new];
        [self.directButton setTitle:@"我先看看" forState:UIControlStateNormal];
        [self.directButton setTitleColor:MMColorBlack forState:UIControlStateNormal];
        [self.directButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self.directButton addTarget:self action:@selector(directPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.directButton];
        
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"注册"
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(registerPressed:)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WS(ws);
    
    [self.loginBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.view.mas_top).with.offset(40);
        make.height.mas_equalTo(self.nameImage.intrinsicContentSize.height * 2);
    }];
    
    [self.nameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.loginBGView);
        make.height.mas_equalTo(self.nameImage.intrinsicContentSize.height);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.loginBGView);
        make.height.mas_equalTo(self.nameImage.mas_height);
        make.width.mas_equalTo(80);
    }];
    
    [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.height.mas_equalTo(self.nameImage.mas_height);
        make.width.mas_equalTo(80);
    }];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.nameLabel);
    }];
    
    [self.passField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passLabel.mas_right).with.offset(5);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.passLabel);
        make.bottom.mas_equalTo(self.passLabel);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).with.offset(20);
        make.right.mas_equalTo(ws.view).with.offset(-20);
        make.top.mas_equalTo(self.loginBGView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [self.forgetPassButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginButton);
        make.right.mas_equalTo(ws.view.mas_centerX);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.directButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view.mas_centerX);
        make.right.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.forgetPassButton);
        make.bottom.mas_equalTo(self.forgetPassButton);
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.loginButton.enabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//登录请求
-(void)loginPressed:(id)sender{
    if(![tooles verifyInputs:self.nameField.text forInputType:EInputUsername]){
        [self showError:@"请正确填写用户名，长度在5-20的中英文组合！"];
        return;
    }
    if(![tooles verifyInputs:self.passField.text forInputType:EInputUsername]){
        [self showError:@"请正确填写密码，长度在5-20的中英文组合！"];
        return;
    }
    [SVProgressHUD showWithStatus:@"loading..."];
    [self resignAllTextField];
    [SVProgressHUD showWithStatus:@"loading..."];
    [AVUser logInWithUsernameInBackground:self.nameField.text
                                 password:self.passField.text
                                    block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [APPALL dismissLoginWindow];
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:[tooles getErrorString:error.code]];
        }
    }];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignAllTextField];
}

-(void)resignAllTextField
{
    [self.nameField resignFirstResponder];
    [self.passField resignFirstResponder];
}

-(void)registerPressed:(id)sender
{
    Register1ViewController *rvc = [Register1ViewController new];
    [self.navigationController pushViewController:rvc animated:YES];
}

-(void)forgetPassPressed:(id)sender
{
    //ForgetPWViewController *rvc = [[ForgetPWViewController alloc] init];
    //[self.navigationController pushViewController:rvc animated:YES];
}

-(void)directPressed:(id)sender
{
    [self resignAllTextField];
    [APPALL dismissLoginWindow];
}

-(void)showError:(NSString*)aStr
{
    if((!aStr) || aStr.length <= 0)
    {
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:aStr];
    }
}

-(void)dealloc
{
    self.nameField = nil;
    self.passField = nil;
    self.loginButton = nil;
    self.forgetPassButton = nil;
}
@end
