//
//  MemoriesDetailViewController.m
//  CSFamilyConnections
//
//  Created by vineeth on 6/4/17.
//  Copyright © 2017 Sanvis Health. All rights reserved.
//

#import "MemoriesDetailViewController.h"
@interface MemoriesDetailViewController ()

@end

@implementation MemoriesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    NSURL *websiteUrl = [NSURL URLWithString:_imgURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webview loadRequest:urlRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menu_ButtonClick:(id)sender {
    /*[self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];*/
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (IBAction)Download_ButtonClick:(id)sender {
    [self saveImageURL:self.imgURL];
}
-(void)saveImageURL:(NSString*)url{
   // [self performSelectorOnMainThread:@selector(showStartSaveAlert) withObject:nil waitUntilDone:YES];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
   // [self performSelectorOnMainThread:@selector(showFinishedSaveAlert) withObject:nil waitUntilDone:YES];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
   /* if(error==nil)
    {
         [uAppDelegate showMessage:@"Picture added to photos" withTitle:@"Message"];
    }
    else
    {
        [uAppDelegate showMessage:@"Save error" withTitle:@"Error"];

    }*/
}
/*
-(void)showStartSaveAlert{
    progressHud.mode = MBProgressHUDModeIndeterminate;
    progressHud.labelText = @"Saving Image...";
    [progressHud show:YES];
}
-(void)showFinishedSaveAlert{
    // Set custom view mode
    progressHud.mode = MBProgressHUDModeCustomView;
    progressHud.labelText = @"Completed";
    [progressHud performSelector:@selector(hide:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.5];
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
