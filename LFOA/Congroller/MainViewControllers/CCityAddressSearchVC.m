//
//  CCityAddressSearchVC.m
//  LFOA
//
//  Created by Stenson on 2018/6/29.
//  Copyright © 2018年  abcxdx@sina.com. All rights reserved.
//

#import "CCityAddressSearchVC.h"
#import "CCityAddressDetailVC.h"
@interface CCityAddressSearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UISearchBar * _searchBar;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArr;
@end

@implementation CCityAddressSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.view.backgroundColor = [UIColor whiteColor];

    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutSubViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)layoutSubViews{

    UISearchBar* searchBar = [self searchBar];
    [self.view addSubview:searchBar];

    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(SCREEN_WIDTH - 50, (IPHONEX ? 44.0 : 20.0f), 40, 44.0f);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget: self action:@selector(popToViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, .1, .1)];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, .1, .1)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(UISearchBar*)searchBar {
    
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.frame = CGRectMake(0, (IPHONEX ? 44.0 : 20.0f), self.view.bounds.size.width - 60, 44.f);
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.backgroundImage = [[UIImage alloc]init];
    [_searchBar becomeFirstResponder];
    
    CAShapeLayer* layer = [self line];
    layer.backgroundColor = CCITY_RGB_COLOR(0, 0, 0, .2f).CGColor;
    layer.frame = CGRectMake(0, 43.5, self.view.bounds.size.width, .5f);
    
    [_searchBar.layer addSublayer:layer];
    
    return _searchBar;
}

-(CAShapeLayer*)line {
    
    CAShapeLayer* line = [CAShapeLayer layer];
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
    line.frame = CGRectMake(0, 44, self.view.bounds.size.width, .5f);
    return line;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    while (cell.contentView.subviews.lastObject) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    CCityAddressListPersonDetailModel * personModel = _dataArr[indexPath.row];
    
    UILabel * nameLab = [UILabel new];
    nameLab.frame  = CGRectMake(10, 10, 60, 60);
    nameLab.clipsToBounds = YES;
    nameLab.layer.cornerRadius = nameLab.frame.size.height / 2;
    nameLab.backgroundColor =MAIN_BLUE_COLOR;
    nameLab.text = personModel.nameText;
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:nameLab];
    
    for (int i = 0; i < 2; i ++ ) {
        UILabel * detailLab = [UILabel new];
        detailLab.frame  = CGRectMake(80, 10 + 30 * i, SCREEN_WIDTH - 90, 30);
        detailLab.text = personModel.nameText;
        detailLab.textColor = MAIN_TEXT_COLOR;
        [cell.contentView addSubview:detailLab];
        if ( i == 1) {
            detailLab.textColor = CCITY_GRAY_TEXTCOLOR;
            detailLab.font = [UIFont systemFontOfSize:13];
            detailLab.text = personModel.deptname;
        }
    }
    
    return cell;
}

-(void)popToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArr.count == 0) {
        return;
    }
    CCityAddressDetailVC * addressDetailVC = [[CCityAddressDetailVC alloc]init];
    addressDetailVC.hidesBottomBarWhenPushed  = YES;
    addressDetailVC.detailModel = _dataArr[indexPath.row];
    [self.navigationController pushViewController:addressDetailVC animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
    _dataArr = [NSMutableArray array];
    for (int i = 0; i < _listModelArr.count; i ++) {
        CCityAddressListPersonListModel * listModel = _listModelArr[i];
        for (int j = 0; j < listModel.groupItmes.count; j ++) {
            CCityAddressListGroupModel * groupModel = listModel.groupItmes[j];
            for (int k = 0; k < groupModel.personItems.count; k ++) {
                CCityAddressListPersonDetailModel * personModel = groupModel.personItems[k];
                if ([personModel.nameText containsString:searchBar.text]) {
                    [_dataArr addObject:personModel];
                }
            }
        }
    }
    
    [_tableView reloadData];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
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
