//
//  ViewController.m
//  SBM AYUR
//
//  Created by vineeth on 12/25/18.
//  Copyright © 2018 MyOrganization. All rights reserved.
//

#import "ViewController.h"
#import "MemoriesViewController.h"
#import "AboutViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    _webview.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {NSLog(@"no");}
    else if (remoteHostStatus == ReachableViaWiFi) {NSLog(@"wifi"); }
    else if (remoteHostStatus == ReachableViaWWAN) {NSLog(@"cell"); }
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://sbmayur.com"]]]];
    [self getDetailsService];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)getDetailsService
{
    
  
  
    NSMutableDictionary *post = [[NSMutableDictionary alloc]init];
    [post setValue:@"name" forKey:@"Key"];
   
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:post options:kNilOptions error:&writeError];
    
    NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
    NSString *urlstring = [NSString stringWithFormat:@"https://sbmayur.com/Homepage/getdetails"];
    [urlrequest setURL:[NSURL URLWithString:urlstring]];
    [urlrequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:jsonData];
    [[[NSURLSession sharedSession] dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil) {
            return ;
        }
        dispatch_async (dispatch_get_main_queue(), ^{
            
            NSError *error1;
            NSMutableArray *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
            NSString *outputString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"message webresponse=%@",outputString);
            NSLog(@"webresponse=%@",res);
            if([[res valueForKey:@"status"] isEqualToString:@"1"]){
                self.bottomView.hidden = false;
                [[self navigationController] setNavigationBarHidden:NO animated:NO];
                UIImage* image3 = [UIImage imageNamed:@"navigation_search.png"];
                CGRect frameimg = CGRectMake(5,5, 50,50);
                
                UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
                [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
                [someButton addTarget:self action:@selector(searchButtonClick)
                     forControlEvents:UIControlEventTouchUpInside];
                [someButton setShowsTouchWhenHighlighted:YES];
                UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
                self.navigationItem.rightBarButtonItem =mailbutton;
              /*  UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                               initWithTitle:@"SEARCH"
                                               style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(searchButtonClick)];
                self.navigationItem.rightBarButtonItem = flipButton;*/
            }
          
        });
        
    }] resume];
    
}
-(void)searchButtonClick {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"Did finish loading...");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}
- (void) handleNetworkChange:(NSNotification *)notice
{
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {NSLog(@"no");}
    else if (remoteHostStatus == ReachableViaWiFi) {NSLog(@"wifi"); }
    else if (remoteHostStatus == ReachableViaWWAN) {NSLog(@"cell"); }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)home_ButtonClick:(id)sender {
    MemoriesViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MemoriesView"];
    [self.navigationController pushViewController:ViewController animated:NO];
}

- (IBAction)detailsButtonClick:(id)sender {
    AboutViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Aboutview"];
    [self.navigationController pushViewController:ViewController animated:NO];
}
@end
