//
//  AppDelegate.h
//  SBM AYUR
//
//  Created by vineeth on 12/25/18.
//  Copyright © 2018 MyOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)showMessage:(NSString*)message withTitle:(NSString *)title;


@end

