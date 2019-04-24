//
//  CCityChoosePeopleVC.h
//  LFOA
//
//  Created by Stenson on 2019/4/20.
//  Copyright © 2019  abcxdx@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^chooseBlock)(NSString * selectPeopleName);

@interface CCityChoosePeopleVC : UIViewController

@property  (nonatomic,copy) chooseBlock chooseBlock;

@end

NS_ASSUME_NONNULL_END
