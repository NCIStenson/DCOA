//
//  CCityOfficalDocDetailVC.h
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/8/3.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import "CCityBaseTableViewVC.h"
#import "CCityOfficalDetailMenuVC.h"

@interface CCityOfficalDocDetailVC : CCityBaseTableViewVC

@property(nonatomic, copy)void (^sendActionSuccessed)(NSIndexPath* indexPath);

@property(nonatomic, assign)CCityOfficalMainStyle      mainStyle;
@property(nonatomic, assign)CCityOfficalDocContentMode conentMode;
@property(nonatomic, strong)NSIndexPath*               indexPath;

@property(nonatomic, strong)NSString* url;
@property(nonatomic, assign)BOOL      isEnd;
/* 取回功能入口在已办箱的详情右上角的弹出菜单   如果是已阅的就不显示如果未阅就显示 */
@property (nonatomic,assign) BOOL isread;

@property(nonatomic, copy)void(^reloadData)(void);

-(instancetype)initWithItmes:(NSArray *)items Id:(NSDictionary*)docId contentModel:(CCityOfficalDocContentMode)contentMode;

@end
