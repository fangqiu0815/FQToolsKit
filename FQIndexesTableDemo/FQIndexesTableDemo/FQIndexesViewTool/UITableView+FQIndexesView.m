//
//  UITableView+FQIndexesView.m
//  FQIndexesTableDemo
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UITableView+FQIndexesView.h"
#import <objc/runtime.h>
#import "FQIndexesView.h"

@interface FQWeakProxy : NSObject

@property (nonatomic, weak) FQIndexesView *indexView;

@end
@implementation FQWeakProxy
@end

@interface UITableView () <FQIndexViewDelegate>

@property (nonatomic, strong) FQIndexesView *fq_indexView;

@end


@implementation UITableView (FQIndexesView)


#pragma mark - Swizzle Method

+ (void)load
{
    [self swizzledSelector:@selector(FQIndexView_didMoveToSuperview) originalSelector:@selector(didMoveToSuperview)];
    [self swizzledSelector:@selector(FQIndexView_removeFromSuperview) originalSelector:@selector(removeFromSuperview)];
}

+ (void)swizzledSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma Add and Remove View

- (void)FQIndexView_didMoveToSuperview
{
    [self FQIndexView_didMoveToSuperview];
    if (self.fq_indexViewDataSource.count && !self.fq_indexView && self.superview) {
        FQIndexesView *indexView = [[FQIndexesView alloc] initWithTableView:self configuration:self.fq_indexViewConfiguration];
        indexView.translucentForTableViewInNavigationBar = self.fq_translucentForTableViewInNavigationBar;
        indexView.delegate = self;
        indexView.dataSource = self.fq_indexViewDataSource;
        [self.superview addSubview:indexView];
        
        self.fq_indexView = indexView;
    }
}

- (void)FQIndexView_removeFromSuperview
{
    if (self.fq_indexView) {
        [self.fq_indexView removeFromSuperview];
        self.fq_indexView = nil;
    }
    [self FQIndexView_removeFromSuperview];
}

#pragma mark - SCIndexViewDelegate

- (void)indexView:(FQIndexesView *)indexView didSelectAtSection:(NSUInteger)section
{
    if (self.fq_indexViewDelegate && [self.delegate respondsToSelector:@selector(tableView:didSelectIndexViewAtSection:)]) {
        [self.fq_indexViewDelegate tableView:self didSelectIndexViewAtSection:section];
    }
}

- (NSUInteger)sectionOfIndexView:(FQIndexesView *)indexView tableViewDidScroll:(UITableView *)tableView
{
    if (self.fq_indexViewDelegate && [self.delegate respondsToSelector:@selector(sectionOfTableViewDidScroll:)]) {
        return [self.fq_indexViewDelegate sectionOfTableViewDidScroll:self];
    } else {
        return FQIndexViewInvalidSection;
    }
}

#pragma mark - Getter and Setter

- (FQIndexesView *)fq_indexView
{
    FQWeakProxy *weakProxy = objc_getAssociatedObject(self, @selector(fq_indexView));
    return weakProxy.indexView;
}

- (void)setFq_indexView:(FQIndexesView *)fq_indexView
{
    if (self.fq_indexView == fq_indexView) return;
    
    FQWeakProxy *weakProxy = [FQWeakProxy new];
    weakProxy.indexView = fq_indexView;
    objc_setAssociatedObject(self, @selector(fq_indexView), weakProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FQIndexesViewConfig *)fq_indexViewConfiguration
{
    FQIndexesViewConfig *fq_indexViewConfiguration = objc_getAssociatedObject(self, @selector(fq_indexViewConfiguration));
    if (!fq_indexViewConfiguration) {
        fq_indexViewConfiguration = [FQIndexesViewConfig configuration];
    }
    return fq_indexViewConfiguration;
}

- (void)setFq_indexViewConfiguration:(FQIndexesViewConfig *)fq_indexViewConfiguration
{
    if (self.fq_indexViewConfiguration == fq_indexViewConfiguration) return;
    
    objc_setAssociatedObject(self, @selector(fq_indexViewConfiguration), fq_indexViewConfiguration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<FQTableViewSectionIndexDelegate>)fq_indexViewDelegate
{
    return objc_getAssociatedObject(self, @selector(fq_indexViewDelegate));
}

- (void)setFq_indexViewDelegate:(id<FQTableViewSectionIndexDelegate>)fq_indexViewDelegate
{
    if (self.fq_indexViewDelegate == fq_indexViewDelegate) return;
    
    objc_setAssociatedObject(self, @selector(fq_indexViewDelegate), fq_indexViewDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fq_translucentForTableViewInNavigationBar
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(fq_translucentForTableViewInNavigationBar));
    return number.boolValue;
}

- (void)setFq_translucentForTableViewInNavigationBar:(BOOL)fq_translucentForTableViewInNavigationBar
{
    if (self.fq_translucentForTableViewInNavigationBar == fq_translucentForTableViewInNavigationBar) return;
    
    objc_setAssociatedObject(self, @selector(fq_translucentForTableViewInNavigationBar), @(fq_translucentForTableViewInNavigationBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.fq_indexView.translucentForTableViewInNavigationBar = fq_translucentForTableViewInNavigationBar;
}

- (NSArray<NSString *> *)fq_indexViewDataSource
{
    return objc_getAssociatedObject(self, @selector(fq_indexViewDataSource));
}

- (void)setFq_indexViewDataSource:(NSArray<NSString *> *)fq_indexViewDataSource
{
    if (self.fq_indexViewDataSource == fq_indexViewDataSource) return;
    objc_setAssociatedObject(self, @selector(fq_indexViewDataSource), fq_indexViewDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!fq_indexViewDataSource || fq_indexViewDataSource.count == 0) {
        [self.fq_indexView removeFromSuperview];
        self.fq_indexView = nil;
        return;
    }
    
    if (!self.fq_indexView && self.superview) {
        FQIndexesView *indexView = [[FQIndexesView alloc] initWithTableView:self configuration:self.fq_indexViewConfiguration];
        indexView.translucentForTableViewInNavigationBar = self.fq_translucentForTableViewInNavigationBar;
        indexView.delegate = self;
        [self.superview addSubview:indexView];
        
        self.fq_indexView = indexView;
    }
    
    self.fq_indexView.dataSource = fq_indexViewDataSource.copy;
}


@end
