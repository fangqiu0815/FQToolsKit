//
//  FQCopyLabelTool.m
//  FQCanCopyLabelDemo
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQCopyLabelTool.h"

@implementation FQCopyLabelTool

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self pressAction];

    }
    return self;
}

// 初始化设置
- (void)pressAction {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 0.25;
    [self addGestureRecognizer:longPress];
}

// 使label能够成为响应事件
- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

// 自定义方法时才显示对就选项菜单，即屏蔽系统选项菜单
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(customCopy:)){
        
        return YES;
    }
    return NO;
}

- (void)customCopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
    NSLog(@"copy content===%@", pasteboard.string);
}
- (void)longPressAction:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"拷贝" action:@selector(customCopy:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = [NSArray arrayWithObjects:copyItem, nil];
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
    }
}

@end
