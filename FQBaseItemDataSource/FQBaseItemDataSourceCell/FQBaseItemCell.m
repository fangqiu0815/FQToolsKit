//
//  FQBaseItemCell.m
//  FQBaseItemDataSource
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQBaseItemCell.h"

@interface FQBaseItemCell()

/** switch按钮 */
@property (nonatomic, strong) UISwitch *switchBtn;


@end

@implementation FQBaseItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setBaseItem:(FQBaseItem *)baseItem
{
    _baseItem = baseItem;
    self.imageView.image = [UIImage imageNamed:baseItem.cellPic];
    self.textLabel.text = baseItem.cellTitle;
    
    
    switch (baseItem.itemType) {
        case FQBaseItemTypeArrow: {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.detailTextLabel.text = @"";
            self.accessoryView = nil;
        }
            break;
        case FQBaseItemTypeDetail: {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.detailTextLabel.text = baseItem.cellDetail;
            self.accessoryView = nil;
        }
            break;
        case FQBaseItemTypeSwitch: {
            if (!_switchBtn) {
                _switchBtn = [[UISwitch alloc] init];
                _switchBtn.on = baseItem.isSwitchOn;
                [_switchBtn addTarget:self action:@selector(switchClickEvent:) forControlEvents:UIControlEventValueChanged];
                self.accessoryType = UITableViewCellAccessoryNone;
                self.detailTextLabel.text = @"";
                self.accessoryView = _switchBtn;
            }
        }
            break;
        case FQBaseItemTypeBadge: {
            
        }
            break;
        default:
            break;
    }
    
}

#pragma mark --- Switch 响应事件 ---
- (void)switchClickEvent:(UISwitch *)sender
{
    if (self.baseItem.switchClickBlock) {
        self.baseItem.switchClickBlock(sender.on);
    }
}



@end
