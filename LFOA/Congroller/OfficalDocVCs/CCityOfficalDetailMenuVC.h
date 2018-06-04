//
//  CCityOfficalDetailMenuVC.h
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/8/7.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCityOfficalDetailMenuVC : UIViewController

@property(nonatomic, copy)void(^pushToNextVC)(UIViewController* viewController);
@property(nonatomic, copy)void(^pushToRoot)(void);

@property(nonatomic, copy)   NSDictionary* ids;
@property(nonatomic, assign) NSInteger     contentMode;

/* 取回功能入口在已办箱的详情右上角的弹出菜单   如果是已阅的就不显示如果未阅就显示 */
@property (nonatomic,assign) BOOL isread;

- (instancetype)initWithStyle:(CCityOfficalMainStyle)style;

@end
