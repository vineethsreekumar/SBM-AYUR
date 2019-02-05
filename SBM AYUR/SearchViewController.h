//
//  SearchViewController.h
//  SBM AYUR
//
//  Created by vineeth on 2/6/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    UIActivityIndicatorView *indicator;
}
@property(nonatomic,strong) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UITableView *memoriesTableview;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
