//
//  XYVipControlView.h
//  XYAlertHUDDemo
//
//  Created by wuxiaoyuan on 2019/9/29.
//  Copyright © 2019 lange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYVipControlView : UIView
+ (XYVipControlView *)vipControlViewWithTitleStr:(NSString *)titleStr contentStr:(NSString *)contentStr btnTitleStr:(NSString *)btnTitleStr closeBlock:(nullable void (^) (void))closeBlock btnClickBlock:(nullable void (^) (void))btnClickBlock;
- (void)showOnView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
