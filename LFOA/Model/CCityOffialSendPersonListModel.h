//
//  CCityOffialSendPersonListModel.h
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/8/12.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCityOfficalSendPersonDetailModel : NSObject

@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* personId;
@property(nonatomic, assign)BOOL      isSelected;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end

@interface CCityOffialSendPersonListModel : NSObject

@property(nonatomic, strong)NSString* groupTitle;
@property(nonatomic, strong)NSMutableArray*  groupItmes;
@property(nonatomic, strong)NSString* fkNode;
@property(nonatomic, assign)BOOL      isOpen;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end

@interface CCityAddressListPersonListModel : NSObject

@property(nonatomic, strong)NSString* groupTitle;
@property(nonatomic, strong)NSMutableArray*  groupItmes;
@property(nonatomic, strong)NSString* groupID;
@property(nonatomic, assign)BOOL      isOpen;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end

@interface CCityAddressListGroupModel : NSObject

@property(nonatomic, strong)NSString* groupTitle;
@property(nonatomic, strong)NSMutableArray*  personItems;
@property(nonatomic, strong)NSString* groupID;
@property(nonatomic, assign)BOOL      isOpen;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end

@interface CCityAddressListPersonDetailModel : NSObject

@property(nonatomic, strong)NSString* sex;
@property(nonatomic, strong)NSString*  personID;
@property(nonatomic, strong)NSString* organization;
@property(nonatomic, strong)NSString* Phone;
@property(nonatomic, strong)NSString* nameText;
@property(nonatomic, strong)NSString* occupation;
@property(nonatomic, strong)NSString* mobilePhone;
@property(nonatomic, strong)NSString* deptname;
@property(nonatomic, strong)NSString* email;
@property(nonatomic, strong)NSString* jnxh;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end


