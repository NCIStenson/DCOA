//
//  CCityHomeCell.h
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/9/5.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSBadgeView.h>
#import "CCityHomeModel.h"

typedef NS_ENUM(NSUInteger, CCityHomeCellPosition) {
    CCityHomeCellPositionLeft = 0,
    CCityHomeCellPositionCenter,
    CCityHomeCellPositionRight,
};

@interface CCityHomeCell : UICollectionViewCell

@property(nonatomic, assign)CCityHomeCellPosition posintion;
@property(nonatomic, assign)CCityHomeModel* model;
@property(nonatomic, strong)UIImageView* mainImageView;
@property(nonatomic, strong)JSBadgeView* badgeView;
@property(nonatomic, strong)UILabel* titleLabel;

@property(nonatomic,strong) UIView * contentAllView;
@property (nonatomic,strong) NSIndexPath * indexPath;

@end
