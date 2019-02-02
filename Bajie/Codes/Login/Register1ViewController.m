//
//  LoginViewController.m
//  RentCar
//
//  Created by sunmingming on 14-4-1.
//  Copyright (c) 2014年 Ebola. All rights reserved.
//

#import "Register1ViewController.h"
#import "GuanyuViewController.h"
#import <Masonry.h>
#import "AppDelegate.h"
#import <FlatUIKit.h>
#import "tooles.h"
#import <SVProgressHUD.h>

@interface Register1ViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong) UILabel* loginBGView;
@property(nonatomic,strong) UIImageView* nameImage;
@property(nonatomic,strong) UIImageView* nameImage2;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *passLabel;
@property(nonatomic,strong) UILabel *pass2Label;
@property(nonatomic,strong) UITextField *nameField;
@property(nonatomic,strong) UITextField *passField;
@property(nonatomic,strong) UITextField *pass2Field;

@property(nonatomic,strong) FUIButton *loginButton;
@property(nonatomic,strong) UIButton *aboutButton;

-(void)loginPressed:(id)sender;
-(void)aboutPressed:(id)sender;

@end

@implementation Register1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"注册";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.loginBGView = [UILabel new];
        self.loginBGView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.loginBGView];
        
        self.nameImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputbg"]];
        self.nameImage.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:self.nameImage];
        
        self.nameImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputbg"]];
        self.nameImage2.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:self.nameImage2];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.text = @"账号";
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.nameLabel];
        
        self.passLabel = [UILabel new];
        self.passLabel.text = @"密码";
        self.passLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.passLabel];
        
        self.pass2Label = [UILabel new];
        self.pass2Label.text = @"重复密码";
        self.pass2Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.pass2Label];
        
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
        
        self.pass2Field = [UITextField new];
        self.pass2Field.keyboardType = UIKeyboardTypeDefault;
        self.pass2Field.secureTextEntry = YES;
        self.pass2Field.returnKeyType = UIReturnKeyDone;
        self.pass2Field.placeholder = @"请再次输入密码";
        self.pass2Field.autocorrectionType = UITextAutocorrectionTypeNo;
        self.pass2Field.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.view addSubview:self.pass2Field];
        
        self.loginButton = [FUIButton new];
        self.loginButton.buttonColor = MMColorRed;
        self.loginButton.shadowColor = MMColorShadowRed;
        self.loginButton.shadowHeight = 3.0f;
        self.loginButton.cornerRadius = 6.0f;
        self.loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.loginButton];
        
        self.aboutButton = [UIButton new];
        [self.aboutButton setTitle:@"注册账号意味着您同意本软件协议，点此查看>>" forState:UIControlStateNormal];
        [self.aboutButton.titleLabel setFont:[UIFont flatFontOfSize:10.0f]];
        [self.aboutButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.aboutButton addTarget:self action:@selector(aboutPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.aboutButton];
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
        make.height.mas_equalTo(self.nameImage.intrinsicContentSize.height * 3);
    }];
    
    [self.nameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.loginBGView);
        make.height.mas_equalTo(self.nameImage.intrinsicContentSize.height);
    }];
    
    [self.nameImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.nameImage.mas_bottom);
        make.height.mas_equalTo(self.nameImage2.intrinsicContentSize.height);
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
    
    [self.pass2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.passLabel.mas_bottom);
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
    
    [self.pass2Field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pass2Label.mas_right).with.offset(5);
        make.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(self.pass2Label);
        make.bottom.mas_equalTo(self.pass2Label);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).with.offset(20);
        make.right.mas_equalTo(ws.view).with.offset(-20);
        make.top.mas_equalTo(self.loginBGView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [self.aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginButton);
        make.right.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(10);
        make.height.mas_equalTo(20);
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.loginButton.enabled = YES;
    self.nameField.text = @"";
    self.passField.text = @"";
    self.pass2Field.text = @"";
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
    if(![self.pass2Field.text isEqualToString:self.passField.text]){
        [self showError:@"两次填写密码不一致！"];
        return;
    }
    if(![tooles verifyInputs:self.passField.text forInputType:EInputUsername]){
        [self showError:@"请正确填写密码，长度在5-20的中英文组合！"];
        return;
    }
    [SVProgressHUD showWithStatus:@"loading..."];
    [self resignAllTextField];
    [SVProgressHUD showWithStatus:@"loading..."];
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = self.nameField.text;// 设置用户名
    user.password =  self.passField.text;// 设置密码
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
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
    [self.pass2Field resignFirstResponder];
}

-(void)aboutPressed:(id)sender
{
    GuanyuViewController *rvc = [GuanyuViewController new];
    [self.navigationController pushViewController:rvc animated:YES];
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
    self.pass2Field = nil;
    self.loginButton = nil;
    self.aboutButton = nil;
}

@end
