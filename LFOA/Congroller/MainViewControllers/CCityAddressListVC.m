//
//  CCityAddressListVC.m
//  LFOA
//
//  Created by Stenson on 2018/6/28.
//  Copyright © 2018年  abcxdx@sina.com. All rights reserved.
//

#define kCellHeight 44.0f

#import "CCityAddressListVC.h"
#import "CCityOffialSendPersonListModel.h"
#import "CCityAddressDetailVC.h"
#import "CCityAddressSearchVC.h"
#import "CCitySecurity.h"
@interface CCityAddressListVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation CCityAddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar.layer addSublayer:[self line]];
    _dataArr = [NSMutableArray new];
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
    
    UISearchBar* searchBar = [self searchBar];
    
    [self.view addSubview:_tableView];
    [self.view addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44.f);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(44.f, 0, 0, 0));
    }];
}

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

-(UISearchBar*)searchBar {
    
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44.f);
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.backgroundImage = [[UIImage alloc]init];

    
    
    CAShapeLayer* layer = [self line];
    layer.backgroundColor = CCITY_RGB_COLOR(0, 0, 0, .2f).CGColor;
    layer.frame = CGRectMake(0, 43.5, self.view.bounds.size.width, .5f);

    [_searchBar.layer addSublayer:layer];
    
    return _searchBar;
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
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(40, 0, SCREEN_WIDTH - 60, kCellHeight);
    [titleBtn setImage:[UIImage imageNamed:@"icon_txl_arrow"] forState:UIControlStateNormal];
    [titleBtn setTitle:[NSString stringWithFormat:@"  %@",groupModel.groupTitle]  forState:UIControlStateNormal];
    [cell.contentView addSubview:titleBtn];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [titleBtn addTarget:self action:@selector(orgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (!groupModel.isOpen) {
        titleBtn.imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    if (groupModel.isOpen && groupModel.personItems.count > 0) {
        
        for (int i = 0; i < groupModel.personItems.count; i++) {
            CCityAddressListPersonDetailModel * detailModel = groupModel.personItems[i];
            
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            titleBtn.frame = CGRectMake(60, kCellHeight + kCellHeight * i, SCREEN_WIDTH - 80, kCellHeight);
            if ([detailModel.sex isEqualToString:@"男"]) {
                [titleBtn setImage:[UIImage imageNamed:@"org_user_man"] forState:UIControlStateNormal];
            }else{
                [titleBtn setImage:[UIImage imageNamed:@"org_user_woman"] forState:UIControlStateNormal];
            }
            titleBtn.tag = 100 + i;
            [titleBtn setTitle:[NSString stringWithFormat:@"  %@",detailModel.nameText]  forState:UIControlStateNormal];
            [cell.contentView addSubview:titleBtn];
            titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [titleBtn addTarget:self action:@selector(personBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, kCellHeight);
    [titleBtn setImage:[UIImage imageNamed:@"icon_txl_arrow"] forState:UIControlStateNormal];
    [titleBtn setTitle:[NSString stringWithFormat:@"  %@",orgModel.groupTitle] forState:UIControlStateNormal];
    [headerView addSubview:titleBtn];
    [titleBtn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = 100 + section;
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (orgModel.isOpen) {
        [UIView animateWithDuration:1 animations:^{
            titleBtn.imageView.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            titleBtn.imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }];
    }

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
    
    CCityAddressDetailVC * addressDetailVC = [[CCityAddressDetailVC alloc]init];
    addressDetailVC.hidesBottomBarWhenPushed  = YES;
    addressDetailVC.detailModel = detailModel;
    [self.navigationController pushViewController:addressDetailVC animated:YES];

}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    CCityAddressSearchVC * searchVC = [[CCityAddressSearchVC alloc]init];
    searchVC.hidesBottomBarWhenPushed  = YES;
    searchVC.listModelArr = _dataArr;
    [self.navigationController pushViewController:searchVC animated:YES];
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
