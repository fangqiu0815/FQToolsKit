//
//  FQExcelView.m
//  FQExcelViewDemo
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQExcelView.h"

#define FQSEPLINEWIDTH 0.2
@interface FQExcelView()<UIScrollViewDelegate>
{
    NSMutableArray *_mergeTitleArray;
}
@property(nonatomic,strong)UIView *titleLeftView;
@property(nonatomic,strong)UIView *titleRightView;
@property(nonatomic,strong)UIScrollView *bodyScrollView;
@property(nonatomic,strong)UIView *bodyLeftView;
@property(nonatomic,strong)UIScrollView *bodyRightScrollView;
@property(nonatomic,strong)UIView *bodyRightScrollViewSubview;

@end

@implementation FQExcelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialization];
    
}

- (void)initialization
{
    /// 标题
    _fq_titleFontColor = [UIColor whiteColor];
    _fq_titleFont = [UIFont systemFontOfSize:16];
    _fq_titleBackgroundColor = [UIColor blueColor];
    _fq_titleLineColor = [UIColor blackColor];
    
    /// 内容
    _fq_contentFontColor = [UIColor darkGrayColor];
    _fq_contentFont = [UIFont systemFontOfSize:14 ];
    _fq_contentLineColor = [UIColor blackColor];
    _fq_bodyLeftEvenBgColor = [UIColor lightGrayColor];
    _fq_bodyLeftUnEvenBgColor = [UIColor whiteColor];
    _fq_bodyRigtEvenBgColor = [UIColor lightGrayColor];
    _fq_bodyRightUnEvenBgColor = [UIColor whiteColor];
    
    ///
    [self.bodyRightScrollView addSubview:self.bodyRightScrollViewSubview];
    [self.bodyScrollView addSubview:self.bodyLeftView];
    [self.bodyScrollView addSubview:self.bodyRightScrollView];
    
    [self addSubview:self.titleLeftView];
    [self addSubview:self.titleRightView];
    [self addSubview:self.bodyScrollView];
    
    ///
    _mergeTitleArray = [[NSMutableArray alloc] init];

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger fixedColWidth = [self updateFixedColumnWidth];
    NSInteger allContentWidth = [self getAllContentWidth];

    _titleLeftView.frame = CGRectMake(0, 0, fixedColWidth, _fq_rowHeight*_fq_fixedRow);
    _titleLeftView.backgroundColor = _fq_titleLineColor;
    
    _titleRightView.frame = CGRectMake(_titleLeftView.frame.size.width,
                                       0,
                                       allContentWidth - _titleLeftView.frame.size.width,
                                       _titleLeftView.frame.size.height);
    _titleRightView.backgroundColor = _fq_titleLineColor;
    
    //该contentSize的高还需在呈现数据的时候动态计算。宽不能变否则就能任何方向滑动了
    _bodyScrollView.frame = CGRectMake(0,
                                       _titleLeftView.frame.size.height,
                                       self.frame.size.width,
                                       self.frame.size.height - _titleLeftView.frame.size.height);
    
    //该高需在datasource赋值后才能计算
    _bodyLeftView.frame = CGRectMake(0,
                                     0,
                                     _titleLeftView.frame.size.width,
                                     (_fq_excelDataSource.count - _fq_fixedRow)*_fq_rowHeight);
    _bodyLeftView.backgroundColor = _fq_contentLineColor;
    
    //该frame的高和contentSize还需在呈现数据的时候动态计算
    _bodyRightScrollView.frame = CGRectMake(_bodyLeftView.frame.size.width,
                                            0,
                                            self.frame.size.width - _bodyLeftView.frame.size.width,
                                            self.frame.size.height - _titleRightView.frame.size.height);
    
    _bodyRightScrollViewSubview.frame = CGRectMake(0, 0,
                                                   allContentWidth - _bodyLeftView.frame.size.width, _bodyLeftView.frame.size.height);
    _bodyRightScrollViewSubview.backgroundColor = _fq_contentLineColor;
    
    [self refreshDataAndView];

}

/// 刷新数据和视图
- (void)refreshDataAndView
{
    for (UILabel *lab in _titleLeftView.subviews){
        [lab removeFromSuperview];
    }
    for (UILabel *lab in _titleRightView.subviews){
        [lab removeFromSuperview];
    }
    for (UILabel *lab in _bodyLeftView.subviews){
        [lab removeFromSuperview];
    }
    for (UILabel *lab in _bodyRightScrollViewSubview.subviews){
        [lab removeFromSuperview];
    }
    [self loadTitle];
    [self loadBody];
    
    
}

//判断是否是被合并的cell
-(BOOL)isMergeCell:(NSInteger)col andRow:(NSInteger)row
{
    for(NSDictionary *dic in _mergeTitleArray)
    {
        if([[dic objectForKey:@"col"] integerValue] == col && [[dic objectForKey:@"row"] integerValue] == row)
        {
            return YES;
        }
    }
    return NO;
}

- (void)loadTitle
{
    float columnOffsetY = 0.0;
    
    //遍历固定行
    for(int fixrow = 0; fixrow < _fq_fixedRow; fixrow++)
    {
        NSInteger columnOffsetLeft = 0;
        NSInteger columnOffsetRight = 0;
        
        NSMutableArray *titleArray = [_fq_excelDataSource objectAtIndex:fixrow];
        
        //遍历改行的titile
        for (int column = 0; column < _fq_columnNum; column++) {
            NSInteger columnWidth = [[_fq_columnsWidthArr objectAtIndex:column] integerValue];
            
            UILabel *lab = [[UILabel alloc] init];
            lab.backgroundColor = _fq_titleBackgroundColor;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = [titleArray objectAtIndex:column];
            lab.font = _fq_titleFont;
            lab.textColor = _fq_titleFontColor;
            
            //leftview
            if (column < _fq_fixedColumn) {
                lab.frame = CGRectMake(columnOffsetLeft, columnOffsetY, columnWidth-FQSEPLINEWIDTH, _fq_rowHeight-FQSEPLINEWIDTH);
                [_titleLeftView addSubview:lab];
                columnOffsetLeft += [[_fq_columnsWidthArr objectAtIndex:column] integerValue];
            }
            //rightview
            else
            {
                //先设置普通情况下的width 如果有合并就在计算合并后的width 再判断是否是被合并的单元格如果是就设置成宽为0
                NSInteger width = columnWidth;
                
                //计算合并的宽
                if(_fq_titleMergeArr)
                {
                    for(NSDictionary *dic in _fq_titleMergeArr)
                    {
                        NSString *col = [dic objectForKey:@"col"];
                        NSString *row = [dic objectForKey:@"row"];
                        NSString *span = [dic objectForKey:@"span"];
                        if(col && row && span)
                        {
                            NSInteger colInt = [col integerValue];
                            NSInteger rowInt = [row integerValue];
                            NSInteger spanInt = [span integerValue];
                            if(column == colInt && fixrow == rowInt)
                            {
                                for(int j = column+1; j<column+spanInt;j++)
                                {
                                    width += [[_fq_columnsWidthArr objectAtIndex:j] integerValue];
                                    [_mergeTitleArray addObject:@{@"col":[NSString stringWithFormat:@"%d",j],@"row":[NSString stringWithFormat:@"%ld",(long)rowInt]}];
                                }
                                break;
                            }
                        }
                    }
                }
                //判断是否被合并
                if([self isMergeCell:column andRow:fixrow]){width = 0;}
                
                lab.frame = CGRectMake(columnOffsetRight, columnOffsetY, (width-FQSEPLINEWIDTH)>=0?(width-FQSEPLINEWIDTH):0, _fq_rowHeight-FQSEPLINEWIDTH);
                
                [_titleRightView addSubview:lab];
                columnOffsetRight += [[_fq_columnsWidthArr objectAtIndex:column] integerValue];
                
            }
        }
        columnOffsetY += _fq_rowHeight;
    }
    
}

- (void)loadBody
{
    NSInteger rowCount = _fq_excelDataSource.count - _fq_fixedRow;
    
    float columnOffsetY = 0.0;
    
    //遍历行
    for (NSInteger row = 0; row < rowCount; row++) {
        
        NSInteger index = row + _fq_fixedRow;
        
        NSInteger columnOffsetLeft = 0;
        NSInteger columnOffsetRight = 0;
        
        NSMutableArray *rowData = [_fq_excelDataSource objectAtIndex:index];
        
        for (int column = 0; column < _fq_columnNum; column++) {
            NSInteger columnWidth = [[_fq_columnsWidthArr objectAtIndex:column] integerValue];
            
            UILabel *lab = [[UILabel alloc] init];
            lab.backgroundColor = [UIColor clearColor];
            lab.textAlignment = NSTextAlignmentCenter;
            [lab setText:[NSString stringWithFormat:@"%@",[rowData objectAtIndex:column]]];
            lab.font = _fq_contentFont;
            lab.textColor = _fq_contentFontColor;
            if (column < _fq_fixedColumn)
            {
                lab.frame = CGRectMake(columnOffsetLeft, columnOffsetY, columnWidth-FQSEPLINEWIDTH, _fq_rowHeight-FQSEPLINEWIDTH);
                //                NSLog(@"left:%ld,%@",(long)row,lab);
                if (row%2 == 0) {
                    lab.backgroundColor = _fq_bodyLeftEvenBgColor;
                }
                else
                {
                    lab.backgroundColor = _fq_bodyLeftUnEvenBgColor;
                }
                [_bodyLeftView addSubview:lab];
                columnOffsetLeft += [[_fq_columnsWidthArr objectAtIndex:column] integerValue];
                
            }
            else
            {
                lab.frame = CGRectMake(columnOffsetRight, columnOffsetY, columnWidth-FQSEPLINEWIDTH, _fq_rowHeight-FQSEPLINEWIDTH);
                //                NSLog(@"right:%ld,%@",(long)row,lab);
                [_bodyRightScrollViewSubview addSubview:lab];
                if (row%2 == 0) {
                    lab.backgroundColor = _fq_bodyRigtEvenBgColor;
                }
                else
                {
                    lab.backgroundColor = _fq_bodyRightUnEvenBgColor;
                }
                columnOffsetRight += [[_fq_columnsWidthArr objectAtIndex:column] integerValue];
                
            }
            
        }
        
        columnOffsetY += _fq_rowHeight;
        
        //scrollview 和 rightScrollView的contentSize
        NSInteger allWidth = [self getAllContentWidth];
        _bodyScrollView.contentSize = CGSizeMake(_bodyScrollView.frame.size.width,
                                                 columnOffsetY);
        _bodyRightScrollView.contentSize = CGSizeMake(allWidth - _bodyLeftView.frame.size.width,
                                                      columnOffsetY);
        _bodyRightScrollView.frame = CGRectMake(_bodyRightScrollView.frame.origin.x,
                                                _bodyRightScrollView.frame.origin.y,
                                                _bodyRightScrollView.frame.size.width,
                                                columnOffsetY);
        
        
    }
}



- (NSInteger)getAllContentWidth
{
    NSInteger allContentWidth = 0;
    for(int col = 0;col < _fq_columnsWidthArr.count ; col++)
    {
        allContentWidth += [[_fq_columnsWidthArr objectAtIndex:col] integerValue];
    }
    return allContentWidth;
}


- (NSInteger)updateFixedColumnWidth
{
    NSInteger fixedColumnWidth = 0;
    for (int col = 0; col < _fq_fixedColumn; col++) {
        fixedColumnWidth += [[_fq_columnsWidthArr objectAtIndex:col] integerValue];
    }
    
    return fixedColumnWidth;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrolX = (scrollView.contentOffset.x - self.titleLeftView.frame.size.width)*-1;
    CGFloat scrolY = 0;
    CGFloat scrolW = self.titleRightView.frame.size.width;
    CGFloat scrolH = self.titleRightView.frame.size.height;
    
    self.titleRightView.frame = CGRectMake(scrolX, scrolY, scrolW, scrolH);
    [self bringSubviewToFront:self.titleLeftView];
}

- (UIView *)titleLeftView
{
    if (!_titleLeftView) {
        _titleLeftView = [[UIView alloc]init];
    }
    return _titleLeftView;
}

- (UIView *)titleRightView
{
    if (!_titleRightView) {
        _titleRightView = [[UIView alloc]init];
    }
    return _titleRightView;
}

- (UIScrollView *)bodyScrollView
{
    if (!_bodyScrollView) {
        _bodyScrollView = [[UIScrollView alloc]init];
        _bodyScrollView.backgroundColor = [UIColor clearColor];
    }
    return _bodyScrollView;
}

- (UIView *)bodyLeftView
{
    if (!_bodyLeftView) {
        _bodyLeftView = [[UIView alloc]init];
    }
    return _bodyLeftView;
}

- (UIScrollView *)bodyRightScrollView
{
    if (!_bodyRightScrollView) {
        _bodyRightScrollView = [[UIScrollView alloc]init];
        _bodyRightScrollView.backgroundColor = [UIColor clearColor];
        _bodyRightScrollView.bounces = NO;
        _bodyRightScrollView.delegate = self;
    }
    return _bodyRightScrollView;
}

- (UIView *)bodyRightScrollViewSubview
{
    if (!_bodyRightScrollViewSubview) {
        _bodyRightScrollViewSubview = [[UIView alloc]init];
        
    }
    return _bodyRightScrollViewSubview;
}







@end
