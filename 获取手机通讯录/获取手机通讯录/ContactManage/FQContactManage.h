//
//  FQContactManage.h
//  FQWuZongSystem
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>//发送短信、、要写代理

//typedef NS_ENUM(NSInteger,FQSendMessageStateType) {
//    FQSendMessageStateTypeSuccess = 0, //成功
//    FQSendMessageStateTypeFail,        //失败
//    FQSendMessageStateTypeCancel,      //取消
//};

/** 获取通讯录回调 */
typedef void(^FQUserContactManageResultBlock)(BOOL success, NSInteger getContactCancleType, NSMutableArray *addressArray);
/** 获取单个用户信息通讯录回调 */
typedef void(^FQSingleUserContactResultBlock)(BOOL success, NSDictionary *phoneDict);
/** 发送短信回调 给用户发送短信 resultType 0.成功 1.失败 2.取消 */
typedef void(^FQSendMessageUserResultBlock)(NSInteger resultType);

@interface FQContactManage : NSObject <CNContactPickerDelegate, ABPeoplePickerNavigationControllerDelegate>

+ (instancetype )contactManage;

@property (copy, nonatomic) FQSingleUserContactResultBlock completionClickBlock;

@property (copy, nonatomic) FQUserContactManageResultBlock userContactClickBlock;

@property (copy, nonatomic) FQSendMessageUserResultBlock sendMessageResultBlock;

- (void)getUserContactDataWithResult:(FQUserContactManageResultBlock)result;

- (void)getSingleUserContactDataWithResult:(FQSingleUserContactResultBlock)result;

- (void)getIOSNineLaterSinglePersonWithResult:(FQSingleUserContactResultBlock)result;

- (void)sendMesage:(NSString *)message sendPersonArray:(NSArray <NSString *> *)personArray withMessageResult:(FQSendMessageUserResultBlock)result;



@end
