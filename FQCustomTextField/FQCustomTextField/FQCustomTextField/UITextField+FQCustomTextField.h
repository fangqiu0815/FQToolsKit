//
//  UITextField+FQCustomTextField.h
//  FQCustomTextField
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UITextField (FQCustomTextField)<UITextViewDelegate>

/**
 UITextField：placeholder：文字颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *fq_placeholderColor;

/**
 UITextField：placeholder：文字字体
 */
@property(nonatomic, strong) UIFont *fq_placeholderFont;

/**
 UITextField：限制最大输入长度
 */
@property(nonatomic, assign) NSInteger fq_maxLength;

/**
 UITextField：小数点后的最大位数，默认：无，
 注意：如果需要使用此方法，键盘默认为 UIKeyboardTypeDecimalPad，请务必遵循两步：
 // 先设置 _textField2 的代理
 [_textField2 ba_textField_setDelegate:_textField2];
 // 再设置小数点后的位数，如果不使用 ba_maxDecimalPointNumber ，请务必删除 上面的代理，以免出现其他异常
 _textField2.ba_maxDecimalPointNumber = 2;
 */
@property(nonatomic, assign) NSInteger fq_maxDecimalPointNumber;

/**
 UITextField：是否包含小数点，默认：NO
 */
@property(nonatomic, assign) BOOL fq_isHaveDecimalPoint;

/**
 UITextField：首位数是否可以为 0，默认：NO
 */
@property(nonatomic, assign) BOOL fq_isFirstNumberZero;


/**
 UITextField：首先设置代理
 
 @param delegate delegate description
 */
- (void)fq_textField_setDelegate:(id<UITextViewDelegate>)delegate;

/**
 UITextField：判断 UITextField 输入的内容是否为空
 
 @return YES，NO
 */
- (BOOL)fq_textField_isEmpty;

/**
 UITextField：选中所有文字
 */
- (void)fq_textField_selectAllText;

/**
 UITextField：当前选中的字符串范围
 
 @return NSRange
 */
- (NSRange)fq_textField_selectedRange;

/**
 UITextField：选中指定范围的文字
 
 @param range NSRange 范围
 */
- (void)fq_textField_setSelectedRange:(NSRange)range;
////是否筛除emoji表情
//@property (assign , nonatomic) BOOL fq_isEmoticons;            // default is NO
//@property (strong , nonatomic) NSString * lastString;
//@property (assign , nonatomic) BOOL isFirst;



@end
