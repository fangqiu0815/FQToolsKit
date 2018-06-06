//
//  UITextField+FQCustomTextField.m
//  FQCustomTextField
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UITextField+FQCustomTextField.h"
#import "FQConfigDefine.h"

@implementation UITextField (FQCustomTextField)


/**
 UITextField：首先设置代理
 
 @param delegate delegate description
 */
- (void)fq_textField_setDelegate:(id<UITextViewDelegate>)delegate
{
    self.delegate = delegate;
}

/**
 判断 UITextField 输入的是否为空
 
 @return YES，NO
 */
- (BOOL)fq_textField_isEmpty
{
    return (self == nil || self.text == nil || [self.text isEqualToString:@""]);
}

//- (BOOL)fq_isEmoticons
//{
//    return [BAKit_Objc_getObj boolValue];
//}
//
//- (void)setFq_isEmoticons:(BOOL)fq_isEmoticons
//{
//    BAKit_Objc_setObj(@selector(fq_isEmoticons), @(fq_isEmoticons));
//}

//- (NSString *)lastString
//{
//    return [BAKit_Objc_getObj stringValue];
//}
//
//- (void)setLastString:(NSString *)lastString
//{
//    BAKit_Objc_setObj(@selector(lastString), @(lastString));
//}

//-(void)setLastText{
//    UITextPosition* beginning = self.beginningOfDocument;
//    UITextRange* selectedRange = self.selectedTextRange;
//    UITextPosition* selectionStart = selectedRange.start;
//    UITextPosition* selectionEnd = selectedRange.end;
//    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
//    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
//    NSRange range = NSMakeRange(location-(self.text.length-self.lastString.length), length);
//    self.text = self.lastString;
//    beginning = self.beginningOfDocument;
//    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
//    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
//    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
//    [self setSelectedTextRange:selectionRange];
//}
//
//-(void)setDeleteEmojiText{
//    UITextPosition* beginning = self.beginningOfDocument;
//    UITextRange* selectedRange = self.selectedTextRange;
//    UITextPosition* selectionStart = selectedRange.start;
//    UITextPosition* selectionEnd = selectedRange.end;
//    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
//    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
//    NSRange range;
//    if([[self deleteEmojiWithString:self.text] length]<self.text.length){
//        range = NSMakeRange(location-(self.text.length-self.lastString.length), length);
//    }else{
//        range = NSMakeRange(location, length);
//    }
//    [self setText:[self deleteEmojiWithString:self.text]];
//    beginning = self.beginningOfDocument;
//    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
//    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
//    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
//    [self setSelectedTextRange:selectionRange];
//}
//
////筛除emoji表情
//-(NSString *)deleteEmojiWithString:(NSString *)string{
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSString * text = [regex stringByReplacingMatchesInString:string
//                                                      options:0
//                                                        range:NSMakeRange(0, [self.text length])
//                                                 withTemplate:@""];
//    return text;
//}
//

/**
 选中所有文字
 */
- (void)fq_textField_selectAllText
{
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

/**
 当前选中的字符串范围
 
 @return NSRange
 */
- (NSRange)fq_textField_selectedRange
{
    UITextPosition *beginPosition = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginPosition toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}



/**
 选中指定范围的文字
 
 @param range NSRange 范围
 */
- (void)fq_textField_setSelectedRange:(NSRange)range
{
    UITextPosition *beginPosition = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginPosition offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:startPosition offset:NSMaxRange(range)];
    
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (void)handleTextFieldTextDidChangeAction
{
    NSString *toBeginString = self.text;
    // 获取高亮部分
    UITextRange *selectRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectRange.start offset:0];
//    NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];// 键盘输入模式
//
//    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [self markedTextRange];
//        //获取高亮部分
//        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
//        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if(!position) {
//            if (!self.fq_isEmoticons){
//                [self setDeleteEmojiText];
//            }
//            self.lastString = self.text;
//
//        }
//        //有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//            return;
//        }
//
//    }
//    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//    else{
//        if (!self.fq_isEmoticons){
//            [self setDeleteEmojiText];
//        }
//        self.lastString = self.text;
//    }
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    // 在 iOS 7下, position 对象总是不为 nil
    if ((!position || !selectRange) && (self.fq_maxLength > 0 && toBeginString.length > self.fq_maxLength && [self isFirstResponder]))
    {
        NSRange rangeIndex = [toBeginString rangeOfComposedCharacterSequenceAtIndex:self.fq_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeginString substringToIndex:self.fq_maxLength];
        }
        else
        {
            NSRange tempRange = [toBeginString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.fq_maxLength)];
            NSInteger tempLength;
            if (tempRange.length > self.fq_maxLength)
            {
                tempLength = tempRange.length - rangeIndex.length;
            }
            else
            {
                tempLength = tempRange.length;
            }
            self.text = [toBeginString substringWithRange:NSMakeRange(0, tempLength)];
        }
        
    }
    
    
}

#pragma mark - UITextField delegate
// textField.text 输入之前的值 string 输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound)
    {
        self.fq_isHaveDecimalPoint = NO;
    }
    
    //    NSInteger number2 = self.ba_maxDecimalPointNumber;
    BOOL isHaveDecimalPoint = self.fq_isHaveDecimalPoint;
    
    if ([string length] > 0)
    {
        // 当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        if ((single >= '0' && single <= '9') || single == '.')
        {
            // 数据格式正确
            // 首字母不能为 0 和 小数点
            if([textField.text length] == 0)
            {
                if(single == '.')
                {
                    NSLog(@"亲，第一个数字不能为小数点");
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
                if (!self.fq_isFirstNumberZero)
                {
                    if (single == '0')
                    {
                        NSLog(@"亲，第一个数字不能为0");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                
            }
            
            // 输入的字符是否是小数点
            if (single == '.')
            {
                // text 中还没有小数点
                if(!isHaveDecimalPoint)
                {
                    self.fq_isHaveDecimalPoint = YES;
                    return YES;
                }
                else
                {
                    NSLog(@"亲，您已经输入过小数点了");
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDecimalPoint)
                {
                    //存在小数点
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= self.fq_maxDecimalPointNumber)
                    {
                        return YES;
                    }
                    else
                    {
                        NSLog(@"亲，您最多输入两位小数");
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }
        else
        {
            // 输入的数据格式不正确
            NSLog(@"亲，您输入的格式不正确");
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

#pragma mark - setter / getter
- (void)setFq_placeholderColor:(UIColor *)fq_placeholderColor
{
    BAKit_Objc_setObj(@selector(fq_placeholderColor), fq_placeholderColor);
    [self setValue:fq_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)fq_placeholderColor
{
    return BAKit_Objc_getObj;
}

- (void)setFq_placeholderFont:(UIFont *)fq_placeholderFont
{
    BAKit_Objc_setObj(@selector(fq_placeholderFont), fq_placeholderFont);
    [self setValue:fq_placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)fq_placeholderFont
{
    return BAKit_Objc_getObj;
}

- (void)setFq_maxLength:(NSInteger)fq_maxLength
{
    BAKit_Objc_setObj(@selector(fq_maxLength), @(fq_maxLength));
    [self addTarget:self action:@selector(handleTextFieldTextDidChangeAction) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)fq_maxLength
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setFq_maxDecimalPointNumber:(NSInteger)fq_maxDecimalPointNumber
{
    self.keyboardType = UIKeyboardTypeDecimalPad;
    BAKit_Objc_setObj(@selector(fq_maxDecimalPointNumber), @(fq_maxDecimalPointNumber));
}

- (NSInteger)fq_maxDecimalPointNumber
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setFq_isHaveDecimalPoint:(BOOL)fq_isHaveDecimalPoint
{
    BAKit_Objc_setObj(@selector(fq_isHaveDecimalPoint), @(fq_isHaveDecimalPoint));
}

- (BOOL)fq_isHaveDecimalPoint
{
    return [BAKit_Objc_getObj boolValue];
}

- (void)setFq_isFirstNumberZero:(BOOL)fq_isFirstNumberZero
{
    BAKit_Objc_setObj(@selector(fq_isFirstNumberZero), @(fq_isFirstNumberZero));
}

- (BOOL)fq_isFirstNumberZero
{
    return [BAKit_Objc_getObj boolValue];
}



@end
