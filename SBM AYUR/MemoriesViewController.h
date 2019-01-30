//
//  MemoriesViewController.h
//  CSFamilyConnections
//
//  Created by vineeth on 6/4/17.
//  Copyright © 2017 Sanvis Health. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoriesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UIActivityIndicatorView *indicator;
}
@property(nonatomic,strong) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UITableView *memoriesTableview;

@end
