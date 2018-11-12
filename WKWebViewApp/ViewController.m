//
//  ViewController.m
//  WKWebViewApp
//
//  Created by Marco on 27/9/2018.
//  Copyright © 2018 marco. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

// ----------------------------------------------------------------------------
#define SiteName @"name_of_your_site"
#define SiteURL @"http://your_mobile_website_url_here"
// ----------------------------------------------------------------------------

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(weak, nonatomic) IBOutlet WKWebView *webview;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation ViewController
@synthesize webview, loadingView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWebView {
    NSURL *url = [NSURL URLWithString:SiteURL];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
    // Load the request
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate = self;
    [self.webview loadRequest:requestObj];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:SiteName message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:SiteName message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        completionHandler(NO);
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        completionHandler(YES);
    }];
    
    [controller addAction:action1];
    [controller addAction:action2];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation {
    
}

- (void) webView: (WKWebView *) webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.loadingView setHidden:YES];
}

@end
