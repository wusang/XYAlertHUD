//
//  XYAlertViewShadowView.h
//  XYAlertView
//
//
//

#import <UIKit/UIKit.h>

@interface XYAlertViewShadowView : UIView

@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) UIColor *strokeColor;
@property (assign, nonatomic) CGFloat strokeWidth;
@property (strong, nonatomic, nullable) UIColor *shadowColor;
@property (assign, nonatomic) CGFloat shadowBlur;
@property (assign, nonatomic) CGPoint shadowOffset;

@end
