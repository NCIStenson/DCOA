//
//  CCityChoosePeopleVC.m
//  LFOA
//
//  Created by Stenson on 2019/4/20.
//  Copyright © 2019  abcxdx@sina.com. All rights reserved.
//

#define kCellHeight 44.0f

#import "CCityChoosePeopleVC.h"
#import "CCityOffialSendPersonListModel.h"
#import "CCitySecurity.h"
#import "BEMCheckBox.h"

@interface CCityChoosePeopleVC ()<UITableViewDataSource,UITableViewDelegate,BEMCheckBoxDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * submitBtn;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation CCityChoosePeopleVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"请选择接收人";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar.layer addSublayer:[self line]];
    self.dataArr = [NSMutableArray array];
    [self configData];
    [self layoutMySubViews];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    if (_dataArr.count == 0) {
        [self configData];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configData
- (void)configData {
    
    if ([CCitySecurity userListArr] ) {
        NSArray* result = [CCitySecurity userListArr][@"content"];
        _dataArr = [NSMutableArray array];
        for (int i = 0; i < result.count; i ++) {
            CCityAddressListPersonListModel * listModel = [[CCityAddressListPersonListModel alloc]initWithDic:result[i]];
            [_dataArr addObject:listModel];
        }
        
        [_tableView reloadData];
        return;
    }
    [SVProgressHUD show];
    AFHTTPSessionManager* manager = [CCityJSONNetWorkManager sessionManager];
    
    [manager GET:@"service/user/UserList.ashx" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSString* state = responseObject[@"status"];
        if (![state isEqualToString:@"success"]) {
            [CCityAlterManager showSimpleTripsWithVC:self Str:@"数据请求失败" detail:nil];
            return ;
        }
        [CCitySecurity setUserListArr:responseObject];
        
        NSArray* result = responseObject[@"content"];
        _dataArr = [NSMutableArray array];
        for (int i = 0; i < result.count; i ++) {
            CCityAddressListPersonListModel * listModel = [[CCityAddressListPersonListModel alloc]initWithDic:result[i]];
            [_dataArr addObject:listModel];
        }
        
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        [CCityAlterManager showSimpleTripsWithVC:self Str:error.localizedDescription detail:nil];
        
        if (CCITY_DEBUG) {
            
            NSLog(@"%@",task.currentRequest.URL.absoluteString);
            NSLog(@"%@",error);
        }
    }];
}


#pragma mark- --- layout
-(void)layoutMySubViews {
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    _tableView = [self tableView];
    _submitBtn = [self sendBtn];
    [self.view addSubview:_tableView];
    [self.view addSubview:_submitBtn];

    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20.0f);
        if ([[CCitySystemVersionManager deviceStr] isEqualToString:@"iPhone X"] || [[CCitySystemVersionManager deviceStr] isEqualToString:@"iPhone XS"]) {
            make.bottom.equalTo(self.view).with.offset(-26.f);
        }else if([[CCitySystemVersionManager deviceStr] isEqualToString:@"iPhone XR"]){
            make.bottom.equalTo(self.view).with.offset(-36.f);
        }else if([[CCitySystemVersionManager deviceStr] isEqualToString:@"iPhone XS Max"]){
            make.bottom.equalTo(self.view).with.offset(-46.f);
        }else {
            make.bottom.equalTo(self.view).offset(-6.0f);
        }
        make.right.equalTo(self.view).offset(-20.0f);
        make.height.mas_equalTo(@50.f);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(_submitBtn.mas_top).offset(-15);
    }];}

-(CAShapeLayer*)line {
    
    CAShapeLayer* line = [CAShapeLayer layer];
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
    line.frame = CGRectMake(0, 44, self.view.bounds.size.width, .5f);
    return line;
}

//  tableView
-(UITableView*)tableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, .1, .1)];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, .1, .1)];
    //    [_tableView registerClass:[CCityMainTaskSearchCell class] forCellReuseIdentifier:ccityMainTaskSerachCellReuseId];
    //    [_tableView registerClass:[CCityMainTasekSearchResultCell class] forCellReuseIdentifier:ccityMainTaskSerachResultCellReuseId];
    
    _tableView.separatorColor = CCITY_RGB_COLOR(0, 0, 0, .1f);
    _tableView.sectionFooterHeight = .1f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    return _tableView;
}

-(UIButton *)sendBtn{
    UIButton* sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [sendBtn setTitle:@"提 交" forState:UIControlStateNormal];
    sendBtn.backgroundColor = CCITY_MAIN_COLOR;
    sendBtn.clipsToBounds = YES;
    sendBtn.layer.cornerRadius = 5.f;
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    return sendBtn;
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CCityAddressListPersonListModel * orgModel = _dataArr[section];
    
    if (orgModel.isOpen) {
        return orgModel.groupItmes.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCityAddressListPersonListModel * orgModel = _dataArr[indexPath.section];
    CCityAddressListGroupModel * groupModel = orgModel.groupItmes[indexPath.row];
    
    if (groupModel.isOpen) {
        return (groupModel.personItems.count + 1 ) * kCellHeight;
    }
    
    return kCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    while (cell.contentView.subviews.lastObject) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    CCityAddressListPersonListModel * orgModel = _dataArr[indexPath.section];
    CCityAddressListGroupModel * groupModel = orgModel.groupItmes[indexPath.row];
    
    BEMCheckBox * checkBox = [self myCheckBox];
    [cell.contentView addSubview:checkBox];
    [checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(14.f);
        make.left.equalTo(cell.contentView).offset(40.f);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [checkBox setOn:groupModel.isSelect animated:YES];
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(65, 0, SCREEN_WIDTH - 75, kCellHeight);
    [titleBtn setTitle:[NSString stringWithFormat:@"%@",groupModel.groupTitle]  forState:UIControlStateNormal];
    [cell.contentView addSubview:titleBtn];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [titleBtn addTarget:self action:@selector(orgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (groupModel.isOpen && groupModel.personItems.count > 0) {
        for (int i = 0; i < groupModel.personItems.count; i++) {
            CCityAddressListPersonDetailModel * detailModel = groupModel.personItems[i];
            
            BEMCheckBox * checkBox = [self myCheckBox];
            [cell.contentView addSubview:checkBox];
            checkBox.frame = CGRectMake(55, kCellHeight + 14 + kCellHeight * i, 16, 16);
            checkBox.tag = 10000 + i;
            [checkBox setOn:detailModel.isSelect animated:YES];
            
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            titleBtn.frame = CGRectMake(75, kCellHeight + kCellHeight * i, SCREEN_WIDTH - 105, kCellHeight);
            titleBtn.tag = 100 + i;
            [titleBtn setTitle:[NSString stringWithFormat:@"%@",detailModel.nameText]  forState:UIControlStateNormal];
            [cell.contentView addSubview:titleBtn];
            titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [titleBtn addTarget:self action:@selector(personBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn setImage:[UIImage imageNamed:@"ccity_offical_sendDoc_addPerson_50x50_"] forState:UIControlStateNormal];
            titleBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 0, 6, 0)];
            
            if (i != groupModel.personItems.count - 1) {
                CAShapeLayer* layer = [self line];
                layer.backgroundColor = CCITY_RGB_COLOR(0, 0, 0, .1f).CGColor;
                layer.frame = CGRectMake(0, 43.5, self.view.bounds.size.width, .5f);
                
                [titleBtn.layer addSublayer:layer];
            }
        }
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [UIView new];
    CCityAddressListPersonListModel * orgModel = _dataArr[section];
    
    BEMCheckBox * checkBox = [self myCheckBox];
    checkBox.tag = 99999 + section;
    [headerView addSubview:checkBox];
    [checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset(14.f);
        make.left.equalTo(headerView).offset(16.f);
        make.bottom.equalTo(headerView).offset(-12.f);
        make.width.equalTo(checkBox.mas_height);
    }];
    [checkBox setOn:orgModel.isSelect animated:YES];
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(45, 0, SCREEN_WIDTH - 55, kCellHeight);
    [titleBtn setTitle:[NSString stringWithFormat:@"%@",orgModel.groupTitle] forState:UIControlStateNormal];
    [headerView addSubview:titleBtn];
    [titleBtn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = 100 + section;
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCellHeight;
}

-(void)sectionBtnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    
    CCityAddressListPersonListModel * orgModel = _dataArr[index];
    orgModel.isOpen = !orgModel.isOpen;
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)orgBtnClick:(UIButton *)btn
{
    UITableViewCell * cell = (UITableViewCell *)btn.superview.superview;
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    
    CCityAddressListPersonListModel * orgModel = _dataArr[indexPath.section];
    CCityAddressListGroupModel * groupModel = orgModel.groupItmes[indexPath.row];
    groupModel.isOpen = !groupModel.isOpen;
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)personBtnClick:(UIButton *)btn{
    
    UITableViewCell * cell = (UITableViewCell *)btn.superview.superview;
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    
    NSInteger index = btn.tag - 100;
    
    CCityAddressListPersonListModel * orgModel = _dataArr[indexPath.section];
    CCityAddressListGroupModel * groupModel = orgModel.groupItmes[indexPath.row];
    CCityAddressListPersonDetailModel * detailModel = groupModel.personItems[index];
    detailModel.isSelect = !detailModel.isSelect;
    
    BEMCheckBox * checkBox = [btn.superview viewWithTag:10000 + index];
    [checkBox setOn:detailModel.isSelect animated:YES];
}

-(BEMCheckBox*)myCheckBox {
    BEMCheckBox* checkBox = [[BEMCheckBox alloc]init];
    checkBox.boxType = BEMBoxTypeSquare;
    checkBox.onTintColor = CCITY_MAIN_COLOR;
    checkBox.onCheckColor = CCITY_MAIN_COLOR;
    checkBox.delegate = self;
    [checkBox setAnimationDuration:0.1];
    return  checkBox;
}


#pragma mark - BEMCheckBoxDelegate

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if (checkBox.tag >= 99999) {
        NSInteger index = checkBox.tag - 99999;
        CCityAddressListPersonListModel * orgModel = _dataArr[index];
        orgModel.isSelect = !orgModel.isSelect;
        for (CCityAddressListGroupModel * groupModel in orgModel.groupItmes) {
            groupModel.isSelect = orgModel.isSelect;
            for (CCityAddressListPersonDetailModel * model in groupModel.personItems) {
                model.isSelect = groupModel.isSelect;
            }
        }
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else if(checkBox.tag < 10000){
        NSIndexPath * indexPath = [_tableView indexPathForCell:(UITableViewCell *)checkBox.superview.superview];
        CCityAddressListPersonListModel * orgModel = _dataArr[indexPath.section];
        CCityAddressListGroupModel * groupModel = orgModel.groupItmes[indexPath.row];
        groupModel.isSelect = !groupModel.isSelect;
        for (CCityAddressListPersonDetailModel * model in groupModel.personItems) {
            model.isSelect = groupModel.isSelect;
        }
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        NSIndexPath * indexPath = [_tableView indexPathForCell:(UITableViewCell *)checkBox.superview.superview];
        CCityAddressListPersonListModel * orgModel = _dataArr[indexPath.section];
        CCityAddressListGroupModel * groupModel = orgModel.groupItmes[indexPath.row];
        CCityAddressListPersonDetailModel * detailModel = groupModel.personItems[checkBox.tag - 10000];
        detailModel.isSelect = !detailModel.isSelect;
    }
}

-(void)sendAction
{
    NSString * selectPeopleName =@"";
    for (CCityAddressListPersonListModel * orgModel in _dataArr) {
        for (CCityAddressListGroupModel * groupModel in orgModel.groupItmes) {
            for (CCityAddressListPersonDetailModel * model in groupModel.personItems) {
                if (model.isSelect) {
                    if (selectPeopleName.length == 0) {
                        selectPeopleName = model.nameText;
                    }else{
                        selectPeopleName = [NSString stringWithFormat:@"%@,%@",selectPeopleName,model.nameText];
                    }
                }
            }
        }
    }
    self.chooseBlock(selectPeopleName);
    [self.navigationController popViewControllerAnimated:YES];
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
