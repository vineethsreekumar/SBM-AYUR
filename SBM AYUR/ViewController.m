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
#import "SearchViewController.h"
#import "ProductViewController.h"
#import "DYQRCodeDecoderViewController.h"
#import "QRCodeReader.h"
#import "QRCodeReaderViewController.h"

@interface ViewController ()<QRCodeReaderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    _webview.hidden = YES;
    _webview.delegate = self;
    UIImage* image3 = [UIImage imageNamed:@"navigation_search.png"];
    CGRect frameimg = CGRectMake(5,5, 50,50);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(searchButtonClick)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
    [self cameraButtonView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {NSLog(@"no");}
    else if (remoteHostStatus == ReachableViaWiFi) {NSLog(@"wifi"); }
    else if (remoteHostStatus == ReachableViaWWAN) {NSLog(@"cell"); }
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://sbmayur.com"]]]];
    
    self.bottomStackView.hidden = YES;
    self.slideshow.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)cameraButtonView{
    UIImage* image3 = [UIImage imageNamed:@"qrimage.png"];
    CGRect frameimg = CGRectMake(5,5, 50,50);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(qrButtonClick)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem =mailbutton;
}
-(void)qrButtonClick{
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // Define the delegate receiver
    vc.delegate = self;
    
    // Or use blocks
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"%@", resultAsString);
        [self dismissViewControllerAnimated:YES completion:^{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                           message:@"Product not found in our database"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self dismissViewControllerAnimated:YES completion:NULL];
                                                                  }];
            
            [alert addAction:defaultAction];
             [ self presentViewController:alert animated:YES completion:nil];
            
        }];

     /*   UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                       message:@"TProduct not found in our database"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self dismissViewControllerAnimated:YES completion:NULL];
                                                              }];
        
        [alert addAction:defaultAction];
        UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;

        [ top presentViewController:alert animated:YES completion:nil];*/
    }];
    [self presentViewController:vc animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
        
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getDetailsService];
    [self KAslideShow];
}
-(void)KAslideShow
{
    
    
    
    
    //datasource = [@[[UIImage imageNamed:@"logo.png"],[NSURL URLWithString:@"https://i.imgur.com/7jDvjyt.jpg"],@"topbg.png"] mutableCopy];
    datasource = [@[[UIImage imageNamed:@"001.jpg"],
                    @"002.jpg",@"003.jpg"] mutableCopy];
    
    // KASlideshow
    _slideshow.datasource = self;
    _slideshow.delegate = self;
    [_slideshow setDelay:2]; // Delay between transitions
    [_slideshow setTransitionDuration:1]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionSlideHorizontal]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addGesture:KASlideShowGestureTap]; // Gesture t
    
    //[_slideshow start];
}
-(void)viewDidAppear:(BOOL)animated
{
    [_slideshow start];
}
#pragma mark - KASlideShow datasource

- (NSObject *)slideShow:(KASlideShow *)slideShow objectAtIndex:(NSUInteger)index
{
    return datasource[index];
}

- (NSUInteger)slideShowImagesNumber:(KASlideShow *)slideShow
{
    return datasource.count;
}

#pragma mark - KASlideShow delegate

- (void) slideShowWillShowNext:(KASlideShow *)slideShow
{
    // NSLog(@"slideShowWillShowNext, index : %@",@(slideShow.currentIndex));
}

- (void) slideShowWillShowPrevious:(KASlideShow *)slideShow
{
    // NSLog(@"slideShowWillShowPrevious, index : %@",@(slideShow.currentIndex));
}

- (void) slideShowDidShowNext:(KASlideShow *)slideShow
{
    // NSLog(@"slideShowDidShowNext, index : %@",@(slideShow.currentIndex));
}
-(void)getDetailsService
{
    
  
  
    NSMutableDictionary *post = [[NSMutableDictionary alloc]init];
    [post setValue:@"name" forKey:@"Key"];
   
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:post options:kNilOptions error:&writeError];
    
    NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
    NSString *urlstring = [NSString stringWithFormat:@"https://sbmayur.com/Homepage/getstatus"];
    [urlrequest setURL:[NSURL URLWithString:urlstring]];
    [urlrequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:jsonData];
    [[[NSURLSession sharedSession] dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil) {
            self.bottomView.hidden = NO;
            self.bottomStackView.hidden = NO;
            self.slideshow.hidden = NO;
            [[self navigationController] setNavigationBarHidden:NO animated:NO];
            self.navigationController.navigationBar.hidden = NO;
            return ;
        }
        dispatch_async (dispatch_get_main_queue(), ^{
            
            NSError *error1;
            NSMutableArray *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
            NSString *outputString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [SVProgressHUD dismiss];
            NSLog(@"message webresponse=%@",outputString);
            NSLog(@"webresponse=%@",res);
            if([[res valueForKey:@"status"] isEqualToString:@"1"]){
                self.bottomView.hidden = NO;
                self.bottomStackView.hidden = NO;
                self.slideshow.hidden = NO;
                [[self navigationController] setNavigationBarHidden:NO animated:NO];
                self.navigationController.navigationBar.hidden = NO;

              
              /*  UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                               initWithTitle:@"SEARCH"
                                               style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(searchButtonClick)];
                self.navigationItem.rightBarButtonItem = flipButton;*/
            } else {
                self.bottomStackView.hidden = YES;
                self.slideshow.hidden = YES;
                self->_webview.hidden = NO;
            }
          
        });
        
    }] resume];
    
}
-(void)searchButtonClick {
    SearchViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchView"];
    [self.navigationController pushViewController:ViewController animated:NO];
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
- (IBAction)bodyCareButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    ProductViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductView"];
    ViewController.passProductID = [NSNumber numberWithInt: button.tag];
    [self.navigationController pushViewController:ViewController animated:NO];
}

- (IBAction)hairCareButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    ProductViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductView"];
    ViewController.passProductID = [NSNumber numberWithInt: button.tag];
    [self.navigationController pushViewController:ViewController animated:NO];
}

- (IBAction)healthButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    ProductViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductView"];
    ViewController.passProductID = [NSNumber numberWithInt: button.tag];
    [self.navigationController pushViewController:ViewController animated:NO];
}

- (IBAction)lyfeStyleButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    ProductViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductView"];
    ViewController.passProductID = [NSNumber numberWithInt: button.tag];
    [self.navigationController pushViewController:ViewController animated:NO];
}

- (IBAction)menwomenButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    ProductViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductView"];
    ViewController.passProductID = [NSNumber numberWithInt: button.tag];
    [self.navigationController pushViewController:ViewController animated:NO];
}

- (IBAction)skinCareButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    ProductViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductView"];
    ViewController.passProductID = [NSNumber numberWithInt: button.tag];
    [self.navigationController pushViewController:ViewController animated:NO];
}
- (IBAction)shareButtonClick:(id)sender {
    NSString *textToShare = @"Look at this awesome website for SBM Products";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.sbmayur.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    /*
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;*/
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        activityVC.popoverPresentationController.sourceView = self.view;
        activityVC.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
        
    }
    
    [self presentViewController:activityVC animated:YES completion:nil];

}

@end
