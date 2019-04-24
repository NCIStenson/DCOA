//
//  CCityEnmu.h
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/8/11.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#ifndef CCityEnmu_h
#define CCityEnmu_h

#define CCITY_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]

typedef NS_ENUM(NSUInteger, CCityOfficalDetailSectionStyle) {
    
    CCityOfficalDetailNormalStyle = 0,
    CCityOfficalDetailContentSwitchStyle,
    CCityOfficalDetailDateStyle,
    CCityOfficalDetailDateTimeStyle,               // 选择日期和时间
    CCityOfficalDetailSimpleLineTextStyle,
    CCityOfficalDetailMutableLineTextStyle,
    CCityOfficalDetailOpinionStyle,
    CCityOfficalDetailDataExcleStyle,          // 数据网格
    CCityOfficalDetailHuiQianStyle,           // 会签

};

typedef NS_ENUM(NSUInteger, CCityOfficalDocContentMode) {
    
    CCityOfficalDocBackLogMode,
    CCityOfficalDocHaveDoneMode,
    CCityOfficalDocReciveReadMode
};

typedef NS_ENUM(NSUInteger, CCityOfficalMainStyle) {
    
    CCityOfficalMainDocStyle,
    CCityOfficalMainSPStyle,
};
typedef NS_ENUM(NSUInteger, CCHuiQianEditStyle) {
    CCHuiQianEditAddStyle,
    CCHuiQianEditEditStyle,
    CCHuiQianEditCheckStyle,
};

/*
 * 服务器返回代码
 */
typedef NS_ENUM(NSUInteger, CCNetWorkStateErrorCode) {
    
    CCNetWorkStateTokenOutOfData     = 1,     // 用户不存在或TOKEN过期
    CCNetWorkStateListNotConfig      = 100,   // 表单配置文件不存在
    CCNetWorkStateListNotExist       = 101,   // 表单不存在
    CCNetWorkStateLowJurisdiction    = 200,   // 没有权限
    CCNetWorkStateInvalidParameter   = 500,   // 参数无效
    CCNetWorkStateServerExecuteError = 501,   // 执行错误
};

typedef enum : NSUInteger {
    ENTER_PERSONLIST_SEND,
    ENTER_PERSONLIST_READ,
    ENTER_PERSONLIST_GROUPREAD,
} ENTER_PERSONLIST;

typedef enum : NSUInteger {
    ENTER_CYYJ_PEOPLE,
    ENTER_CYYJ_GROUP,
} ENTER_CYYJ;

#endif /* CCityEnmu_h */
