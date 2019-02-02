//
//  UserDataViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/9/27.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "UserDataViewController.h"
#import "MOFSPickerManager.h"
#import "AppDelegate.h"
#import <SVProgressHUD.h>

@interface UserDataViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong) NSString *nicknamestr;
@property(nonatomic,strong) NSString *sexstr;
@property(nonatomic,strong) NSString *citystr;
@property(nonatomic,strong) NSString *birthdaystr;
@property(nonatomic,strong) NSString *btimestr;

@property(nonatomic,assign) int alertTag;

@end

@implementation UserDataViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        AVUser *user = [AVUser currentUser];
        self.nicknamestr = user[@"nickname"];
        self.sexstr = user[@"sex"];
        self.citystr = user[@"city"];
        self.birthdaystr = user[@"birthday"];
        self.btimestr = user[@"btime"];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePressed:)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)savePressed:(id)sender{
    if(!self.nicknamestr.length || self.nicknamestr.length >= 12){
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请正确填写您的姓名！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
        return;
    }
    if(!self.sexstr.length){
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请选择您的性别！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
        return;
    }
    if(!self.birthdaystr.length){
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请选择您的生日！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
        return;
    }
    if(!self.btimestr.length){
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请选择您的生辰！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [vc addAction:cancelAction];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self presentViewController:vc animated:YES completion:nil];
			});
        return;
    }
    AVUser *user = [AVUser currentUser];
    [user setObject:self.nicknamestr forKey:@"nickname"];
    [user setObject:self.sexstr forKey:@"sex"];
    [user setObject:self.citystr forKey:@"city"];
    [user setObject:self.birthdaystr forKey:@"birthday"];
    [user setObject:self.btimestr forKey:@"btime"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"保存失败，请检查网络后稍后再试！"];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 2;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"characteristicCell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"姓名";
                    cell.detailTextLabel.text = self.nicknamestr;
                }
                    break;
                case 1:{
                    cell.textLabel.text = @"性别";
                    cell.detailTextLabel.text = self.sexstr;
                }
                    break;
                case 2:{
                    cell.textLabel.text = @"省市";
                    cell.detailTextLabel.text = self.citystr;
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"生日";
                    cell.detailTextLabel.text = self.birthdaystr;
                }
                    break;
                case 1:{
                    cell.textLabel.text = @"生辰";
                    cell.detailTextLabel.text = self.btimestr;
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请输入您的名字" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    [vc addTextFieldWithConfigurationHandler:^(UITextField *textField){
                        textField.placeholder = @"";
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        UITextField *login = vc.textFields.firstObject;
                        NSLog(@"%@",login.text);
                        if(login.text.length){
                            self.nicknamestr = login.text;
                            [self.tableView reloadData];
                        }
                    }];
                    [vc addAction:cancelAction];
                    [vc addAction:okAction];
					dispatch_async(dispatch_get_main_queue(), ^{
						[self presentViewController:vc animated:YES completion:nil];
					});
                }
                    break;
                case 1:{
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请选择您的性别" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction *ok1Action = [UIAlertAction actionWithTitle:@"男"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        self.sexstr = @"男";
                        [self.tableView reloadData];
                    }];
                    UIAlertAction *ok2Action = [UIAlertAction actionWithTitle:@"女"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        self.sexstr = @"女";
                        [self.tableView reloadData];
                    }];
                    [vc addAction:ok1Action];
                    [vc addAction:ok2Action];
                    [vc addAction:cancelAction];
					dispatch_async(dispatch_get_main_queue(), ^{
						[self presentViewController:vc animated:YES completion:nil];
					});
                }
                    break;
                case 2:{
                    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
                        self.citystr = address;
                        [self.tableView reloadData];
//                        lb.text = address;
                    } cancelBlock:^{
                        
                    }];
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
                        NSDateFormatter *df = [NSDateFormatter new];
                        df.dateFormat = @"yyyy-MM-dd";
                        self.birthdaystr = [df stringFromDate:date];
                        [self.tableView reloadData];
                    } cancelBlock:^{
                        
                    }];
                }
                    break;
                case 1:{
                    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"不清楚",@"子时(23时至01时)",@"丑时(01时至03时)",@"寅时(03时至05时)",@"卯时(05时至07时)",@"辰时(07时至09时)",@"巳时(09时至11时)",@"午时(11时至13时)",@"未时(13时至15时)",@"申时(15时至17时)",@"酉时(17时至19时)",@"戌时(19时至21时)",@"亥时(21时至23时)"] tag:1 title:nil cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
                        if(string.length > 5)
                            self.btimestr = [string substringToIndex:2];
                        else
                            self.btimestr = string;
                        [self.tableView reloadData];
                    } cancelBlock:^{
                        
                    }];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

@end
