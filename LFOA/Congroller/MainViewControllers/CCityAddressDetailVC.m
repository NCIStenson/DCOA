//
//  CCityAddressDetailVC.m
//  LFOA
//
//  Created by Stenson on 2018/6/28.
//  Copyright © 2018年  abcxdx@sina.com. All rights reserved.
//

#import "CCityAddressDetailVC.h"
#import "CCityBaseTableViewCell.h"
#import "CCityBackToLeftView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CCitySystemVersionManager.h"

@interface CCityAddressDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation CCityAddressDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人资料";
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.shadowImage = [self createImageWithColor:[UIColor lightGrayColor]];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:[self backCon]];
    
    UITableView* tableView = [self tableView];
    if ([[CCitySystemVersionManager deviceStr] isEqualToString:@"iPhone X"]) {
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_HEIGHT);
    }else{
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_HEIGHT);
    }
    [self.view addSubview:tableView];
    
    
    UIView * callNumView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT)];
    [self.view addSubview:callNumView];
    
    for (int i = 0; i < 2; i ++) {
        UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(SCREEN_WIDTH / 2 * i,0 , SCREEN_WIDTH / 2, 40.0f);
        titleBtn.tag = 100 + i;
        if(i == 1){
            [titleBtn setImage:[UIImage imageNamed:@"user_mobile"] forState:UIControlStateNormal];
        }else{
            [titleBtn setImage:[UIImage imageNamed:@"user_tel"] forState:UIControlStateNormal];
        }
        [callNumView addSubview:titleBtn];
        [titleBtn addTarget:self action:@selector(callBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark- --- layout

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UITableView*)tableView {
    
    UITableView* tableView = [UITableView new];
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = CCITY_MAIN_BGCOLOR;
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
}

-(UIControl*)backCon {
    
    UIControl* backCon = [UIControl new];
    backCon.frame = CGRectMake(0, 0, 60, 44);
    [backCon addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    CCityBackToLeftView* backView = [CCityBackToLeftView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 10, 15, 24);
    
    UILabel* backLabel = [UILabel new];
    backLabel.text = @"返回";
    backLabel.frame = CGRectMake(20, 0, 40, 44);
    
    [backCon addSubview:backView];
    [backCon addSubview:backLabel];
    
    return backCon;
}

#pragma mark- --- methods
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addHeaderImageWithCell:(UITableViewCell*)cell {
    
    UIImageView* headerImageView = [UIImageView new];
    headerImageView.layer.cornerRadius = 20.f;
    headerImageView.clipsToBounds = YES;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"ccity_uesrcenter_userHeader"]];
    
    [cell.contentView addSubview:headerImageView];
    
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(cell.contentView).with.offset(15.f);
        make.right.equalTo(cell.contentView).with.offset(-10.f);
        make.bottom.equalTo(cell.contentView).with.offset(-15.f);
        make.width.equalTo(headerImageView.mas_height);
    }];
}

#pragma mark- --- UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            
            return 80.f;
            break;
        case 1:
            
            return 20.f;
            break;
        default:
            break;
    }
    
    return 44.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCityBaseTableViewCell* cell = [[CCityBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    switch (indexPath.row) {
            
        case 0:
            
            cell.textLabel.text = @"头像";
            [self addHeaderImageWithCell:cell];
            break;
        case 1:
            
            cell.backgroundColor = CCITY_MAIN_BGCOLOR;
            cell.lineColor = CCITY_MAIN_BGCOLOR;
            break;
        case 2:
            
            cell.textLabel.text = @"名称";
            cell.detailTextLabel.text = _detailModel.nameText;
            break;
        case 3:
            
            cell.textLabel.text = @"单位";
            cell.detailTextLabel.text = _detailModel.organization;
            break;
        case 4:
            
            cell.textLabel.text = @"岗位";
            cell.detailTextLabel.text = _detailModel.occupation;
            break;
        case 5:
            
            cell.textLabel.text = @"科室";
            cell.detailTextLabel.text = _detailModel.deptname;
            break;
        case 6:
            
            cell.textLabel.text = @"电话";
            cell.detailTextLabel.text =_detailModel.Phone;
            cell.detailTextLabel.textColor = MAIN_BLUE_COLOR;
            break;
            
        case 7:
            
            cell.textLabel.text = @"局内小号";
            cell.detailTextLabel.text = _detailModel.jnxh;
            cell.detailTextLabel.textColor = MAIN_BLUE_COLOR;
            break;

        case 8:
            
            cell.textLabel.text = @"手机";
            cell.detailTextLabel.text = _detailModel.mobilePhone;
            cell.detailTextLabel.textColor = MAIN_BLUE_COLOR;
            break;

        case 9:
            
            cell.textLabel.text = @"电子邮件";
            cell.detailTextLabel.text = _detailModel.email;
            cell.detailTextLabel.textColor = MAIN_BLUE_COLOR;
            break;

        default:
            break;
    }
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9 ){
        return YES;
    }
    return NO;// 设置哪里都能显示。
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    // 设置只能复制
    if (action == @selector(cut:)){
        return NO;
    }
    else if(action == @selector(copy:)){
        return YES;
    }
    else if(action == @selector(paste:)){
        return NO;
    }
    else if(action == @selector(select:)){
        return NO;
    }
    else if(action == @selector(selectAll:)){
        return NO;
    }
    else{
        return [super canPerformAction:action withSender:sender];
    }
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    NSString *phoneStr = _detailModel.mobilePhone;
    
    if (indexPath.row == 6) {
        phoneStr = _detailModel.Phone;
    }else  if (indexPath.row == 7){
        phoneStr = _detailModel.jnxh;
    }else  if (indexPath.row == 8){
        phoneStr = _detailModel.mobilePhone;
    }else  if (indexPath.row == 9){
        phoneStr = _detailModel.email;
    }
    
    if (action == @selector(copy:)) {
        //  把获取到的字符串放置到剪贴板上
        [UIPasteboard generalPasteboard].string = phoneStr;
    }
}

-(void)callBtnClick:(UIButton *)btn
{
    if (btn.tag == 100) {
        if (_detailModel.Phone.length > 0) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",_detailModel.Phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            [self showStatusViewWithStr:@"号码为空，不能拨号！"];
        }
    }else{
        if (_detailModel.mobilePhone.length > 0) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",_detailModel.mobilePhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            [self showStatusViewWithStr:@"号码为空，不能拨号！"];
        }
    }
}

-(void)showStatusViewWithStr:(NSString *)str
{
    [SVProgressHUD showWithStatus:str];
    [SVProgressHUD dismissWithDelay:1.5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
