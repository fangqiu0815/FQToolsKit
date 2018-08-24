//
//  ViewController.m
//  获取手机通讯录
//
//  Created by Herman on 2018/7/24.
//  Copyright © 2018年 HeQian. All rights reserved.
//

#import "ViewController.h"
#import "FQContactManage.h"

//记得plis文件中添加这个字段：  Privacy - Contacts Usage Description
@interface ViewController ()<CNContactPickerDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic,strong)NSMutableDictionary * myDict;
@end

@implementation ViewController
- (IBAction)fsada:(id)sender {
    
    //判断授权
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusDenied) {
        
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
            }
        }];
    }
    
    CNContactStore *contactStore = [CNContactStore new];
    NSArray *keys = @[CNContactPhoneNumbersKey,
                      CNContactGivenNameKey,
                      CNContactFamilyNameKey,
                      ];
    // 获取通讯录中所有的联系人
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        for (CNLabeledValue *labeledValue in contact.phoneNumbers){
            CNPhoneNumber *phoneValue = labeledValue.value;
            NSString *phoneNumber = phoneValue.stringValue;
                        NSLog(@"%@: %@",nameStr,phoneNumber);
            //
        }
    }];
    
    NSLog(@"sss");
    NSLog(@"sss");
    NSLog(@"sss");
}
- (IBAction)sendmessage:(id)sender {
    
    [[FQContactManage contactManage] sendMesage:@"你好你好" sendPersonArray:@[@"18159244865"] withMessageResult:^(NSInteger resultType) {
        if (resultType == 0) {
            NSLog(@"发送成功");
        }else if(resultType == 1){
            NSLog(@"发送失败");
        }else{
            NSLog(@"发送取消");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10000,11000"] options:@{} completionHandler:^(BOOL success) {
//
//    }];
//    [self showMesage:@"afafafs"];
  
    
}
- (void)requestAuthorizationAddressBook {
    // 判断是否授权
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
        // 请求授权
        ABAddressBookRef addressBookRef =  ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {  // 授权成功
                
            } else {        // 授权失败
                NSLog(@"授权失败！");
            }
        });
        
    }
}
- (IBAction)pushtoxxx:(id)sender {
    
    AB_DEPRECATED("Use CNContactPickerViewController from ContactsUI.framework instead")
    CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
    contactVc.delegate = self;
    [self presentViewController:contactVc animated:YES completion:nil];
}

// 选择某个联系人时调用
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    CNPhoneNumber *phoneValue= contactProperty.value;
    NSString *phoneNumber = phoneValue.stringValue;
    NSLog(@"%@--%@",name, phoneNumber);
}
// 1.选择联系人时使用（不展开详情）
- (void)contactPicker:(CNContactPickerViewController    *)picker didSelectContact:(CNContact *)contact;
{
    
}
//注：如果有上面的方法，下面的方法不执行}

// 2.选择联系人某个属性时调用（展开详情）
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty;
//{
//
//}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
