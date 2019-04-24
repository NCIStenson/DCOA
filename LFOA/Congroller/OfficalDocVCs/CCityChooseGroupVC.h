//
//  CCityChooseGroupVC.h
//  LFOA
//
//  Created by Stenson on 2019/4/24.
//  Copyright © 2019  abcxdx@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^chooseBlock)(NSString * selectPeopleName);

@interface CCityChooseGroupVC : UIViewController
@property  (nonatomic,copy) chooseBlock chooseBlock;

@end

NS_ASSUME_NONNULL_END
