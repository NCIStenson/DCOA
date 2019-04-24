//
//  CCityCYVC.m
//  LFOA
//
//  Created by Stenson on 2019/4/23.
//  Copyright © 2019  abcxdx@sina.com. All rights reserved.
//

#import "CCityCYVC.h"
#import "CCityChoosePeopleVC.h"
#import "CCityChooseGroupVC.h"
#define textViewStr @"传阅意见"

@interface CCityCYVC ()<UITextViewDelegate>

@property (nonatomic,strong) UIButton * peopleBtn;
@property (nonatomic,strong) UILabel * peopleLab;
@property (nonatomic,strong) UITextView * opinionTextView;
@property (nonatomic,strong) UIButton * submitBtn;

@property (nonatomic,copy) NSString * selectPeopleNameStr;

@end

@implementation CCityCYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAIN_LINE_COLOR;
    if (_enterType == ENTER_CYYJ_PEOPLE) {
        self.title = @"填写传阅意见";
    }else if (_enterType == ENTER_CYYJ_GROUP){
        self.title = @"分组传阅";
    }
    [self initView];
    [self getOpinionText];
}

-(void)initView{
    [self.view addSubview:self.peopleBtn];
    [self.view addSubview:self.opinionTextView];
    
    [self.peopleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
    }];
    
    [self.peopleBtn addSubview:self.peopleLab];
    [self.peopleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.peopleBtn).offset(10);
        make.right.mas_equalTo(self.peopleBtn).offset(-10);
        make.bottom.mas_equalTo(self.peopleBtn.mas_bottom).offset(-10);
    }];
     
     [self.opinionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.mas_equalTo(self.peopleBtn);
         make.top.mas_equalTo(self.peopleBtn.mas_bottom).offset(10);
         make.height.mas_equalTo(100);
     }];
    
    _submitBtn = [self sendBtn];
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

}

-(UIButton *)peopleBtn{
    if (!_peopleBtn) {
        _peopleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_peopleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _peopleBtn.clipsToBounds = YES;
        _peopleBtn.layer.cornerRadius = 5.f;
        _peopleBtn.titleLabel.numberOfLines = 0;
        _peopleBtn.layer.borderColor = [MAIN_DEEPLINE_COLOR CGColor];
        _peopleBtn.layer.borderWidth = 1;
        _peopleBtn.backgroundColor = [UIColor whiteColor];
        [_peopleBtn addTarget:self action:@selector(goChooseNumberVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _peopleBtn;
}


-(UILabel *)peopleLab{
    if (!_peopleLab) {
        _peopleLab = [[UILabel alloc]init];
        _peopleLab.preferredMaxLayoutWidth = SCREEN_WIDTH - 40;//给一个maxWidth
        [_peopleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _peopleLab.text = @"接收人员";
        _peopleLab.textColor = [UIColor lightGrayColor];
        _peopleLab.numberOfLines = 0;
        _peopleLab.font = [UIFont systemFontOfSize:14];
    }
    return _peopleLab;
}

-(UITextView *)opinionTextView{
    if (!_opinionTextView) {
        _opinionTextView = [[UITextView alloc]init];
        _opinionTextView.layer.cornerRadius = 5.f;
        _opinionTextView.layer.borderColor = [MAIN_DEEPLINE_COLOR CGColor];
        _opinionTextView.layer.borderWidth = 1;
        _opinionTextView.backgroundColor = [UIColor whiteColor];
        _opinionTextView.delegate = self;
        _opinionTextView.text = textViewStr;
        _opinionTextView.textColor = [UIColor lightGrayColor];
        _opinionTextView.font = [UIFont systemFontOfSize:14];

        CGFloat xMargin = 5, yMargin = 5;
        // 使用textContainerInset设置top、left、right
        _opinionTextView.textContainerInset = UIEdgeInsetsMake(yMargin, xMargin, 0, xMargin);
        //当光标在最后一行时，始终显示低边距，需使用contentInset设置bottom.
        _opinionTextView.contentInset = UIEdgeInsetsMake(0, 0, yMargin, 0);
        //防止在拼音打字时抖动
        _opinionTextView.layoutManager.allowsNonContiguousLayout = NO;
    }
    return _opinionTextView;
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

#pragma mark - 选择组织

-(void)goChooseNumberVC
{
    if (_enterType == ENTER_CYYJ_PEOPLE) {
        CCityChoosePeopleVC * choosePeople = [[CCityChoosePeopleVC alloc]init];
        choosePeople.chooseBlock = ^(NSString * _Nonnull selectPeopleName) {
            _selectPeopleNameStr = selectPeopleName;
            if (_selectPeopleNameStr.length > 0) {
                _peopleLab.text = _selectPeopleNameStr;
                _peopleLab.textColor = [UIColor blackColor];
            }else{
                _peopleLab.text = @"接收人员";
                _peopleLab.textColor = [UIColor lightGrayColor];
            }
        };
        [self.navigationController pushViewController:choosePeople animated:YES];
    }else if (_enterType == ENTER_CYYJ_GROUP){
        CCityChooseGroupVC * choosePeople = [[CCityChooseGroupVC alloc]init];
        choosePeople.chooseBlock = ^(NSString * _Nonnull selectPeopleName) {
            NSLog(@" =====  %@",selectPeopleName);
            _selectPeopleNameStr = selectPeopleName;
            if (_selectPeopleNameStr.length > 0) {
                _peopleLab.text = _selectPeopleNameStr;
                _peopleLab.textColor = [UIColor blackColor];
            }else{
                _peopleLab.text = @"接收人员";
                _peopleLab.textColor = [UIColor lightGrayColor];
            }
        };
        [self.navigationController pushViewController:choosePeople animated:YES];
    }
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:textViewStr]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = textViewStr;
        textView.textColor = [UIColor lightGrayColor];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self downTheKeyBoard];
}

-(void)textViewDidChange:(UITextView *)textView
{

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self downTheKeyBoard];
}


-(void)downTheKeyBoard
{
    [_opinionTextView resignFirstResponder];
}

#pragma mark - request

-(void)getOpinionText{
    [SVProgressHUD show];
    AFHTTPSessionManager* mananger = [CCityJSONNetWorkManager sessionManager];
    NSDictionary* ids = @{
                          @"workid" :_ids[@"workId"],
                          @"token":[CCitySingleton sharedInstance].token,
                          @"fk_node":_ids[@"fkNode"],
                          };
    [mananger GET:@"service/gw/GetCyOpinion.ashx" parameters:ids progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
            NSString * content = [responseObject objectForKey:@"content"];
            if (content.length > 0) {
                _opinionTextView.text = content;
                _opinionTextView.textColor = [UIColor blackColor];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (CCITY_DEBUG) {  NSLog(@"%@",error); }
    }];
}

-(void)sendAction{
    if (_selectPeopleNameStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择接收人！"];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    NSString * opinionStr = @"";
    if (_opinionTextView.text.length == 0 || [_opinionTextView.text isEqualToString:textViewStr]) {
        [SVProgressHUD showErrorWithStatus:@"请填写传阅意见！"];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }else{
        opinionStr = _opinionTextView.text;
    }
    
    [SVProgressHUD show];
    AFHTTPSessionManager* mananger = [CCityJSONNetWorkManager sessionManager];
    
    NSString * fId = _ids[@"fId"];
    if ([CCUtil isEmpty:fId]) {
        fId = @"";
    }
    NSLog(@" ====  %@",_ids);
    NSDictionary* ids = @{
                          @"token":[CCitySingleton sharedInstance].token,
                          @"workId" :_ids[@"workId"],
                          @"fId"    :fId,
                          @"fkNode" :_ids[@"fkNode"],
                          @"fkFlow" :_ids[@"fk_flow"],
                          @"people" :_selectPeopleNameStr,
                          @"opinion":opinionStr,
                          };
    [mananger GET:@"service/gw/Cy.ashx" parameters:ids progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
            [SVProgressHUD showInfoWithStatus:@"提交成功"];
            [SVProgressHUD dismissWithDelay:2];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"提交失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (CCITY_DEBUG) {  NSLog(@"%@",error); }
    }];
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
