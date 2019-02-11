//
//  ProductViewController.h
//  SBM AYUR
//
//  Created by vineeth on 2/12/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UIActivityIndicatorView *indicator;
}
@property(nonatomic,strong) NSNumber *passProductID;
@property(nonatomic,strong) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UITableView *memoriesTableview;

@end
