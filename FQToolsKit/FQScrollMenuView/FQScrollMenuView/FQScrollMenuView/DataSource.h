//
//  DataSource.h
//  FQScrollMenuView
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FQScrollMenu.h"

@interface DataSource : NSObject<FQObjectProtocol>

/**
 *  text
 */
@property (nonatomic, copy) NSString *itemDescription;
/**
 *  image(eg.NSURL ,NSString ,UIImage)
 */
@property (nonatomic, strong) id itemImage;
/**
 *  placeholderImage
 */
@property (nonatomic, strong) UIImage *itemPlaceholder;

@end
