//
//  CCityChooseGroupVC.m
//  LFOA
//
//  Created by Stenson on 2019/4/24.
//  Copyright © 2019  abcxdx@sina.com. All rights reserved.
//

#import "CCityChooseGroupVC.h"
#import "BEMCheckBox.h"

#import "CCityOffialSendPersonListModel.h"

@interface CCityChooseGroupVC ()<UITableViewDataSource,UITableViewDelegate,BEMCheckBoxDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * submitBtn;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation CCityChooseGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分组列表";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];

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
    [SVProgressHUD show];
    AFHTTPSessionManager* manager = [CCityJSONNetWorkManager sessionManager];
    NSDictionary* ids = @{@"token":[CCitySingleton sharedInstance].token};
    [manager GET:@"service/gw/CyGroup.ashx" parameters:ids progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSArray* result = responseObject[@"results"];
        if (result) {
            for (NSDictionary * dic in result) {
                CCityCYGroupModel * model = [[CCityCYGroupModel alloc]initWithDic:dic];
                [_dataArr addObject:model];
            }
            [_tableView reloadData];
        }
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
    CCityCYGroupModel * orgModel = _dataArr[section];
    if (!orgModel.CHECKED) {
        return 0;
    }
    return 1;
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
    CCityCYGroupModel * orgModel = _dataArr[indexPath.section];

    cell.contentView.backgroundColor = MAIN_LINE_COLOR;
    UILabel * contentLab = [self peopleLab];
    contentLab.text = orgModel.CONTENT;
    [cell.contentView addSubview:contentLab];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).offset(20);
        make.top.mas_equalTo(cell.contentView).offset(10);
        make.right.mas_equalTo(cell.contentView).offset(-20);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom).offset(-10);
    }];
    
    return cell;
}

-(UILabel *)peopleLab{
    
    UILabel * _peopleLab = [[UILabel alloc]init];
    _peopleLab.preferredMaxLayoutWidth = SCREEN_WIDTH - 40;//给一个maxWidth
    [_peopleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _peopleLab.textColor = [UIColor lightGrayColor];
    _peopleLab.numberOfLines = 0;
    _peopleLab.font = [UIFont systemFontOfSize:14];
    
    return _peopleLab;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [UIView new];
    CCityCYGroupModel * orgModel = _dataArr[section];
    
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
    titleBtn.frame = CGRectMake(45, 0, SCREEN_WIDTH - 55, 44);
    [titleBtn setTitle:[NSString stringWithFormat:@"%@",orgModel.NAME] forState:UIControlStateNormal];
    [headerView addSubview:titleBtn];
    [titleBtn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = 100 + section;
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(void)sectionBtnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    CCityCYGroupModel * orgModel = _dataArr[index];
    orgModel.CHECKED = !orgModel.CHECKED;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    NSInteger index = checkBox.tag - 99999;
    CCityCYGroupModel * orgModel = _dataArr[index];
    orgModel.isSelect = !orgModel.isSelect;
    [checkBox setOn:orgModel.isSelect animated:YES];
}

-(void)sendAction
{
    NSString * selectPeopleName =@"";
    for (CCityCYGroupModel * orgModel in _dataArr) {
        if (orgModel.isSelect) {
            if (selectPeopleName.length == 0) {
                selectPeopleName = orgModel.CONTENT;
            }else{
                selectPeopleName = [NSString stringWithFormat:@"%@,%@",selectPeopleName,orgModel.CONTENT];
            }
        }
    }
    self.chooseBlock(selectPeopleName);
    [self.navigationController popViewControllerAnimated:YES];
}



@end
