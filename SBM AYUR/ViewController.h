//
//  ViewController.h
//  SBM AYUR
//
//  Created by vineeth on 12/25/18.
//  Copyright © 2018 MyOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "KASlideShow.h"

@interface ViewController : UIViewController<UIWebViewDelegate,KASlideShowDelegate,KASlideShowDataSource>{
    Reachability* reachability;
    
        NSMutableArray * datasource;
}
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;
- (IBAction)home_ButtonClick:(id)sender;
- (IBAction)detailsButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIStackView *bottomStackView;

@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)bodyCareButtonClick:(id)sender;
- (IBAction)hairCareButtonClick:(id)sender;
- (IBAction)healthButtonClick:(id)sender;
- (IBAction)lyfeStyleButtonClick:(id)sender;
- (IBAction)menwomenButtonClick:(id)sender;
- (IBAction)skinCareButtonClick:(id)sender;

@end

