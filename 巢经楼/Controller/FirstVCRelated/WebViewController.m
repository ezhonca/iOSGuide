//
//  WebViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/28.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic)UIBarButtonItem *favoriteBarButtonItem;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
    //self.webView.delegate = self;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:120]];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com"]]];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center = self.view.center;
     [self.activityIndicator startAnimating];
    self.navigationItem.rightBarButtonItem = self.favoriteBarButtonItem;
    [self.view addSubview:self.activityIndicator];
    
   
    //self.activityIndicator.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(NSMutableSet *)favoriteSet
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.favoriteMutableSet;
}

-(UIBarButtonItem *)favoriteBarButtonItem
{
    if(_favoriteBarButtonItem == nil){
        if([[self favoriteSet] containsObject:self.name]){
            _favoriteBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"isFavorite"] style:UIBarButtonItemStylePlain target:self action:@selector(favoriteBarButtonClick:)];
        }else{
             _favoriteBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"isNotFavorite"] style:UIBarButtonItemStylePlain target:self action:@selector(favoriteBarButtonClick:)];
        }
       
    }
    
    return _favoriteBarButtonItem;
}

- (void)favoriteBarButtonClick:(id)sender
{
    if([[self favoriteSet] containsObject:self.name]){
        [BookmarkHandle DeleteBookmark:self.name];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"isNotFavorite"]];
    }else{
        [BookmarkHandle InsertBookmark:self.name WithBookmarkUrl:self.urlString];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"isFavorite"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.activityIndicator startAnimating];
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    //[self.activityIndicator stopAnimating];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.activityIndicator stopAnimating];
    
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
}
//-(void)webViewDidStartLoad:(UIWebView *)webView {
//    //self.activityIndicator.hidden = NO;
//    [self.activityIndicator startAnimating];
//}
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView {
//    [self.activityIndicator stopAnimating];
//    //self.activityIndicator.hidden = YES;
//}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:self.urlString]];
//    [self.webView loadRequest:request];
   }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
