//
//  CCityMainDocSearchCell.h
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/9/13.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import "CCityBaseTableViewCell.h"
#import "CCityMainDocSearchModel.h"
#import "CCityAppendixView.h"

@interface CCityMainDocSearchCell : CCityBaseTableViewCell

@property(nonatomic, strong)CCityMainDocsearchDetailModel* model;

@property(nonatomic, assign)BOOL isOpen;

@property(nonatomic, strong)CCityAppendixView* accessoryCon;
@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UILabel* fromLabel;

-(CGFloat)getCellHeightWithModel:(CCityMainDocsearchDetailModel*)model;

@end
