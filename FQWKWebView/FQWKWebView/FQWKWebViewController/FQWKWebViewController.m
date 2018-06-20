//
//  FQWKWebViewController.m
//  FQWKWebView
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQWKWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
// iPhone X
#define KDM_iPhoneX ( ScreenW == 375.f && ScreenH == 812.f ? YES : NO)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 自定义颜色 */
#define CUSTOMCOLOR(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
/** 带透明度的自定义颜色 */
#define CUSTOMCOLORA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef enum{
    loadWebURLString = 0,
    loadWebHTMLString,
    POSTWebURLString,
}wkWebLoadType;

static void *WkwebBrowserContext = &WkwebBrowserContext;
@interface FQWKWebViewController ()
<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate,UIScrollViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;
//仅当第一次的时候加载本地JS
@property(nonatomic,assign) BOOL needLoadJSPOST;
//网页加载的类型
@property(nonatomic,assign) wkWebLoadType loadType;
//保存的网址链接
@property (nonatomic, copy) NSString *URLString;
//保存POST请求体
@property (nonatomic, copy) NSString *postData;
//保存请求链接
@property (nonatomic)NSMutableArray* snapShotsArray;
//返回按钮
@property (nonatomic)UIBarButtonItem* customBackBarItem;
//关闭按钮
@property (nonatomic)UIBarButtonItem* closeButtonItem;

@property (nonatomic, strong) WKUserContentController * UserContentController;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;


@end

@implementation FQWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor], [UIFont systemFontOfSize:17 ], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    //加载web页面
    [self webViewloadURLType];
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    //添加进度条
    [self.view addSubview:self.progressView];
    
    UIImage* backItemImage = [UIImage imageNamed:@"btn_back" ];
    UIButton* backButton = [[UIButton alloc] init];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [backButton setTitle:@"返回" forState:0];
    [backButton setTitleColor:[UIColor blackColor] forState:0];
    [backButton setImage:backItemImage forState:UIControlStateNormal];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
    _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self updateNavigationItems];
    
    //    [self.navigationController.navigationBar setBackgroundImage:MyImage(@"bg_gradient") forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor greenColor]] forBarMetrics:UIBarMetricsDefault];
    
    
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_isNavHidden == YES) {
        self.navigationController.navigationBarHidden = YES;
        //创建一个高20的假状态栏
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        //设置成绿色
        statusBarView.backgroundColor = [UIColor redColor];
        // 添加到 navigationBar 上
        [self.view addSubview:statusBarView];
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}

-(void)customBackItemClicked{
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ================ 加载方式 ================

- (void)webViewloadURLType{
    switch (self.loadType) {
        case loadWebURLString:{
            //创建一个NSURLRequest 的对象
            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
            break;
        }
        case loadWebHTMLString:{
            [self loadHostPathURL:self.URLString];
            break;
        }
        case POSTWebURLString:{
            // JS发送POST的Flag，为真的时候会调用JS的POST方法
            self.needLoadJSPOST = YES;
            //POST使用预先加载本地JS方法的html实现，请确认WKJSPOST存在
            [self loadHostPathURL:@"WKJSPOST"];
            break;
        }
    }
}

- (void)loadHostPathURL:(NSString *)url{
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    //获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js
    [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

// 调用JS发送POST请求
- (void)postRequestWithJS {
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@',{%@});", self.URLString, self.postData];
    // 调用JS代码
    [self.wkWebView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
    }];
}


- (void)loadWebURLSring:(NSString *)string{
    self.URLString = string;
    self.loadType = loadWebURLString;
}

- (void)loadURL:(NSURL *)URL {
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadWebHTMLSring:(NSString *)string{
    self.URLString = string;
    self.loadType = loadWebHTMLString;
}

- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData{
    self.URLString = string;
    self.postData = postData;
    self.loadType = POSTWebURLString;
}

#pragma mark ================ 自定义返回/关闭按钮 ================
-(void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}
//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"about blank!! return");
        return;
    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if(webView == self.wkWebView) {
        // 禁止放大缩小
        NSString *injectionJSString = @"var script = document.createElement('meta');" "script.name = 'viewport';" "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";" "document.getElementsByTagName('head')[0].appendChild(script);";
        [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    }
    // 判断是否需要加载（仅在第一次加载）
    if (self.needLoadJSPOST) {
        // 调用使用JS发送POST请求的方法
        [self postRequestWithJS];
        // 将Flag置为NO（后面就不需要加载了）
        self.needLoadJSPOST = NO;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
    
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    
}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    }
    
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    UIApplication *app = [UIApplication sharedApplication];
    // 打电话
    if ([scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    // 打开appstore
    if ([url.absoluteString containsString:@"itunes.apple.com"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([self isWirelessDownloadManifestForURL:url]) {
        //当前加载链接为苹果企业APP无线安装清单文件，则打开外部浏览器进行展示
        [app openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if(![self externalAppRequiredToOpenURL:url]) {
        if(!navigationAction.targetFrame) {
            [self loadURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        BOOL decision = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
        if (decision) {
            decisionHandler(WKNavigationActionPolicyAllow);
            return;
        } else
        {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        
    }
    else if([[UIApplication sharedApplication] canOpenURL:url]) {
        [self launchExternalAppWithURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (BOOL)isWirelessDownloadManifestForURL:(NSURL*)url
{
    //    JLLog(@"url.absoluteString = %@ ",url.absoluteString);
    if (!url.absoluteString) {
        return NO;
    }
    
    NSString *urlString = url.absoluteString;
    if ([urlString hasPrefix:@"itms-services://?action=download-manifest&url="]) {
        return YES;
    }
    return NO;
}

-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    //back delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(FQWebView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.delegate FQWebView:self.wkWebView shouldStartLoadWithRequest:request navigationType:navigationType];
    }else
    {
        return YES;
    }
}

#pragma mark - External App Support
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    
    //若需要限制只允许某些前缀的scheme通过请求，则取消下述注释，并在数组内添加自己需要放行的前缀
    //    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
    //    return ![validSchemes containsObject:URL.scheme];
    
    return !URL;
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
    self.URLToLaunchWithPermission = URL;
    if (![self.externalAppPermissionAlertView isVisible]) {
        [self.externalAppPermissionAlertView show];
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView == self.externalAppPermissionAlertView) {
        if(buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
        }
        self.URLToLaunchWithPermission = nil;
    }
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载超时");
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}


#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark ================ WKScriptMessageHandler ================
//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    if ([message.name isEqualToString:@"WXPay"]) {
        NSLog(@"%@", message.body);
        //调用微信支付方法
        //        [self WXPayWithParam:message.body];
    }
}

#pragma mark ================ 懒加载 ================

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        if (@available(iOS 9.0, *)) {
            Configuration.allowsAirPlayForMediaPlayback = YES;
        }

        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        
        NSMutableString *str = [NSMutableString string];
        // 去掉导航页，如果想把“腾讯新闻”导航栏一并去掉
        [str appendString:@""];
        
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:str injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        self.UserContentController = UserContentController;
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        [UserContentController addUserScript:wkUserScript];
        
        CGFloat wkWebViewH = 0.0;
        if (iOS11Later) {
            wkWebViewH = KDM_iPhoneX?ScreenH-88:ScreenH-64;
        } else {
            wkWebViewH = ScreenH-20;
        }
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, wkWebViewH) configuration:Configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        
        //开启手势触摸
        if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
            _wkWebView.allowsBackForwardNavigationGestures = YES;
        } else {
            _wkWebView.allowsBackForwardNavigationGestures = NO;
        }
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (_isNavHidden == YES) {
            _progressView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor blueColor];
    }
    return _progressView;
}

-(UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
        _closeButtonItem.tintColor = [UIColor whiteColor];
        
    }
    return _closeButtonItem;
}

-(NSMutableArray*)snapShotsArray{
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.UserContentController removeAllUserScripts];
    self.navigationController.navigationBarHidden = NO;
    
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


//注意，观察的移除
-(void)dealloc{
    NSLog(@"dealloc");
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.UserContentController removeAllUserScripts];
    [self.wkWebView.scrollView setDelegate:nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark -获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentViewController
{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
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

@end
