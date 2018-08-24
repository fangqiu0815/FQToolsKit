//
//  FQContactManage.m
//  FQWuZongSystem
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQContactManage.h"
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

@interface FQContactManage()<MFMessageComposeViewControllerDelegate>



@end

@implementation FQContactManage

+ (instancetype )contactManage
{
    static FQContactManage * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[FQContactManage alloc] init];
        }
    });
    return manager;
}

- (void)getIOSNineLaterSinglePersonWithResult:(FQSingleUserContactResultBlock)result
{
    if (@available(iOS 9.0, *)) {
        //让用户给权限,没有的话会被拒的各位
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    //提示授权
                    UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\n设置-隐私-通讯录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alart show];
                }else
                {
                    NSLog(@"chenggong ");//用户给权限了
                    CNContactPickerViewController * picker = [CNContactPickerViewController new];
                    picker.delegate = self;
                    picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];//只显示手机号
                    [[self getCurrentViewController] presentViewController: picker  animated:YES completion:nil];
                }
            }];
        }
        
        if (status == CNAuthorizationStatusAuthorized) {//有权限时
            CNContactPickerViewController * picker = [CNContactPickerViewController new];
            picker.delegate = self;
            picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
            [[self getCurrentViewController] presentViewController: picker  animated:YES completion:nil];
        }
        else{
            //提示授权
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\n设置-隐私-通讯录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
        }
        
    } else {
        // Fallback on earlier versions
    }
    
}

// ============== contacts
#pragma mark - 选中一个联系人
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact API_AVAILABLE(ios(9.0)){
    NSLog(@"contact:%@",contact);
    NSLog(@"name:%@%@",contact.familyName,contact.givenName);
    //获取联系人详细信息,如:姓名,电话,住址等信息
    NSString *firstName = contact.familyName;
    NSString *lastName = contact.givenName;
    //phoneNumbers 包含手机号和家庭电话等
    NSString *phone = @"";
    for (CNLabeledValue * labeledValue in contact.phoneNumbers) {
        CNPhoneNumber * phoneNumber = labeledValue.value;
        phone = phoneNumber.stringValue;
        NSLog(@"phoneNum:%@", phoneNumber.stringValue);
    }
    
    //判断姓名null
    NSString *allName;
    if (![self isBlankString:firstName] && ![self isBlankString:lastName]) {
        allName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
    }else if(![self isBlankString:firstName]){
        allName = firstName;
    }else if (![self isBlankString:lastName]){
        allName = lastName;
    }else{
        allName = @"";
    }
    NSString *phoneNO = phone;
    NSString *personStr = allName;
    personStr = [self clearBlankSpaceString:personStr];
    
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (phone) {
        NSDictionary *dict = @{
                               @"person":personStr,
                               @"phonenum":phoneNO
                               };
        if (self.completionClickBlock) {
            self.completionClickBlock(YES, dict);
        };
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }else{
        NSLog(@"手机号码格式错误");
        if (self.completionClickBlock) {
            self.completionClickBlock(NO, nil);
        };
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker API_AVAILABLE(ios(9.0)){
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ================= 授权是否使用用户通讯录 =========================
- (void)requestAuthorizationAddressBook
{
    // 判断是否授权
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
        // 请求授权
        ABAddressBookRef addressBookRef = ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) { // 授权成功
                
            } else {  // 授权失败
                NSLog(@"授权失败！");
            }
        });
    }
}


+ (void)getUserContactDataWithResult:(FQUserContactManageResultBlock)result
{
    if (@available(iOS 9.0, *)) {
        //判断授权
        CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusDenied) {
            result(NO, 2, nil);
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\n设置-隐私-通讯录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            return;
            
        }
        if (authorizationStatus == CNAuthorizationStatusNotDetermined)
        {
            CNContactStore *store = [CNContactStore new];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted){
                    NSLog(@"授权成功!");
                }else{
                    NSLog(@"授权失败!");
                    result(NO, 0, nil);
                }
            }];
        }
        if (authorizationStatus == CNAuthorizationStatusAuthorized) {
            CNContactStore *contactStore = [CNContactStore new];
            NSArray *keys = @[CNContactPhoneNumbersKey,
                              CNContactGivenNameKey,
                              CNContactFamilyNameKey,
                              ];
            // 获取通讯录中所有的联系人
            CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
            NSMutableArray *contacts = [NSMutableArray array];
            [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
                for (CNLabeledValue *labeledValue in contact.phoneNumbers){
                    CNPhoneNumber *phoneValue = labeledValue.value;
                    NSString *phoneNumber = phoneValue.stringValue;
                    NSLog(@"%@: %@",nameStr,phoneNumber);
                    NSString *string = [NSString stringWithFormat:@"%@:%@",nameStr,phoneNumber];
                    [contacts addObject:string];
                    //
                }
            }];
            if (contacts.count != 0) {
                result(YES, 3, contacts);
            }else{
                result(YES, 3, nil);
            }
        }
        
    } else {
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();

        if (authStatus == kABAuthorizationStatusNotDetermined)
        {
            //获取授权
            ABAddressBookRef addressBook = ABAddressBookCreate();
            ABAddressBookRequestAccessWithCompletion( addressBook, ^(bool granted, CFErrorRef error) {
                if (granted){
//                    NSMutableArray *contacts = [self a];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        result(granted, authStatus, contacts);
//                    });
                }else{
                    result(granted, authStatus, nil);
                }
            });
        }
        else if(authStatus == kABAuthorizationStatusRestricted)
        {
            NSLog(@"用户拒绝");
            result(NO, authStatus, nil);
        }
        else if (authStatus == kABAuthorizationStatusDenied)
        {
            NSLog(@"用户拒绝");
            result(NO, authStatus, nil);
        }
        else if (authStatus == kABAuthorizationStatusAuthorized)
        {
//            //获取授权
//            ABAddressBookRef addressBook = ABAddressBookCreate();
//
//            NSMutableArray *contacts = [self fetchContactWithAddressBook:addressBook];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                result(YES, authStatus, contacts);
//            });
        }
    }
}


- (NSMutableArray *)fetchContactWithAddressBook:(ABAddressBookRef)addressBook
{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {////有权限访问
        //获取联系人数组
        NSArray *array = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *contacts = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            //获取联系人
            ABRecordRef people = CFArrayGetValueAtIndex((__bridge ABRecordRef)array, i);
            //获取联系人详细信息,如:姓名,电话,住址等信息
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonLastNameProperty);
            
            //判断姓名null
            NSString *allName;
            if (![self isBlankString:firstName] && ![self isBlankString:lastName]) {
                allName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
            }else if(![self isBlankString:firstName]){
                allName = firstName;
            }else if (![self isBlankString:lastName]){
                allName = lastName;
            }else{
                allName = @"";
            }
            
            ABMutableMultiValueRef phoneNumRef = ABRecordCopyValue(people, kABPersonPhoneProperty);
            NSString *phoneNumber =  ((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneNumRef)).lastObject;
            //判断手机号null
            NSString *phone;
            if (![self isBlankString:phoneNumber]) {
                phone = phoneNumber;
            }else{
                phone = @"";
            }
            
            //如果不加上面的判断，这里加入数组的时候会出错，不会判断(null)这个东西，所以要先排除
            [contacts addObject:@{@"name": allName, @"phoneNumber": phone}];
            
        }
        return contacts;
    }else{//无权限访问
        //提示授权
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\n设置-隐私-通讯录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return nil;
    }
}

- (void)getSingleUserContactDataWithResult:(FQSingleUserContactResultBlock)result
{
    [self requestAuthorizationAddressBook];
    
    // 1. 判读授权
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus != kABAuthorizationStatusAuthorized) {
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\n设置-隐私-通讯录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.displayedProperties = @[@(kABPersonPhoneProperty)];
    nav.peoplePickerDelegate = self;
    self.completionClickBlock = result;
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0){
        nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    }
    [[self getCurrentViewController] presentViewController:nav animated:YES completion:nil];
}

//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    //获取联系人详细信息,如:姓名,电话,住址等信息
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    //判断姓名null
    NSString *allName;
    if (![self isBlankString:firstName] && ![self isBlankString:lastName]) {
        allName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
    }else if(![self isBlankString:firstName]){
        allName = firstName;
    }else if (![self isBlankString:lastName]){
        allName = lastName;
    }else{
        allName = @"";
    }
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    NSString *personStr = allName;
    personStr = [self clearBlankSpaceString:personStr];
    phoneNO = [self clearBlankSpaceString:phoneNO];
    phoneNO = [self fq_filterSpecialString:phoneNO];// 手机号去除无关项
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
    if ([self isPhoneNoNowWithPhoneNum:phoneNO]) {
        NSDictionary *dict = @{
                               @"person":personStr,
                               @"phonenum":phoneNO
                               };
        if (self.completionClickBlock) {
            self.completionClickBlock(YES, dict);
        };
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }else{
        NSLog(@"手机号码格式错误");
        if (self.completionClickBlock) {
            self.completionClickBlock(NO, nil);
        };
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}


// 3.取消选中联系人时调用
- (void)sendMesage:(NSString *)message sendPersonArray:(NSArray <NSString *> *)personArray withMessageResult:(FQSendMessageUserResultBlock)result;
{
    if ([MFMessageComposeViewController canSendText]) {
        /** 创建短信界面(控制器*/
        MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
        //        DeviceManager * ma = [DeviceManager shareManager];
        controller.recipients = personArray;//短信接受者为一个NSArray数组
        controller.body = message;//短信内容
        controller.messageComposeDelegate = self;//设置代理,代理可不是 controller.delegate = self 哦!!!
        self.sendMessageResultBlock = result;
        /** 取消按钮的颜色(附带,可不写) */
        //controller.navigationBar.tintColor = [UIColor redColor];
        [[self getCurrentViewController] presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"模拟器不支持发送短信");
    }
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    /** 发送完信息就回到原程序*/
    [[self getCurrentViewController] dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            if (self.sendMessageResultBlock) {
                self.sendMessageResultBlock(0); /// 成功
            }
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            if (self.sendMessageResultBlock) {
                self.sendMessageResultBlock(1); /// 失败
            }
            break;
        case MessageComposeResultCancelled:
            NSLog(@"发送取消");
            if (self.sendMessageResultBlock) {
                self.sendMessageResultBlock(2);  /// 取消
            }
        default:
            break;
    }
}



- (NSString *)fq_filterSpecialString:(NSString *)string
{
    if (string == nil)
    {
        return @"";
    }
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

/**
 * 其他 ***********************************************
 */
#pragma mark -获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentViewController
{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = [UIColor whiteColor];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *result = window.rootViewController;
    result.view.backgroundColor = [UIColor whiteColor];
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    
    return result;
    
    
}


- (BOOL)isPhoneNoNowWithPhoneNum:(NSString *)phoneNum
{
    if (phoneNum.length != 11) return NO; //截止到2018-1-17 的手机号
    NSString *MOBILE = @"^1((2[0-9]|3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:self] == YES){
        return YES;
    }else{
        return NO;
    }
}


- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

#pragma mark -清除字符串中的空格
- (NSString*)clearBlankSpaceString:(NSString *)string
{
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return string;
}


@end
