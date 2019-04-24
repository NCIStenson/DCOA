//
//  CCityOffialSendPersonListModel.m
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/8/12.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import "CCityOffialSendPersonListModel.h"

@implementation CCityOfficalSendPersonDetailModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        [self configDataWithDic:dic];
    }
    return self;
}

- (void) configDataWithDic:(NSDictionary*)dic {

    NSArray* childrenArr = dic[@"children"];
    
    NSDictionary* childrenDic = childrenArr[0];
    _personId = childrenDic[@"id"];
    _name     = childrenDic[@"text"];
}

@end


@implementation CCityOffialSendPersonListModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        [self configDataWithDic:dic];
    }
    return self;
}

- (void) configDataWithDic:(NSDictionary*)dic {
    
    _isOpen = YES;
    _groupTitle = dic[@"name"];
    _fkNode = [NSString stringWithFormat:@"%@",dic[@"toNode"]];
    
    NSArray* organization = dic[@"organization"];
    NSDictionary* organizDic = organization[0];
            
    NSArray* persons = organizDic[@"children"];
    
    _groupItmes = [NSMutableArray arrayWithCapacity:persons.count];
    
    for (int i = 0; i < persons.count; i++) {
        
        CCityOfficalSendPersonDetailModel* detailModel = [[CCityOfficalSendPersonDetailModel alloc]initWithDic:persons[i]];
        [_groupItmes addObject:detailModel];
    }
    
}

@end

@implementation CCityAddressListPersonListModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        [self configDataWithDic:dic];
    }
    return self;
}

- (void) configDataWithDic:(NSDictionary*)dic {
    
    _isOpen = YES;
    _groupTitle = dic[@"text"];
    _groupID = dic[@"id"];
    
    NSArray* organization = dic[@"children"];

    _groupItmes = [NSMutableArray arrayWithCapacity:organization.count];
    for (int i = 0; i < organization.count; i ++) {
        CCityAddressListGroupModel * groupItemsModel = [[CCityAddressListGroupModel alloc]initWithDic:organization[i]];
        [_groupItmes addObject:groupItemsModel];
    }
}

@end

@implementation CCityAddressListGroupModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        [self configDataWithDic:dic];
    }
    return self;
}

- (void) configDataWithDic:(NSDictionary*)dic {
    
    _isOpen = NO;
    _groupTitle = dic[@"text"];
    _groupID = dic[@"id"];
    
    NSArray* organization = dic[@"children"];
    
    _personItems = [NSMutableArray arrayWithCapacity:organization.count];
    for (int i = 0; i < organization.count; i ++) {
        CCityAddressListPersonDetailModel * groupItemsModel = [[CCityAddressListPersonDetailModel alloc]initWithDic:organization[i]];
        [_personItems addObject:groupItemsModel];
    }
}

@end


@implementation CCityAddressListPersonDetailModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _personID = value;
    }
    if([key isEqualToString:@"text"]){
        _nameText = value;
    }
}

@end

@implementation CCityCYGroupModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        _isSelect = NO;
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"ID"]){
        _groupID = value;
    }
}
@end
