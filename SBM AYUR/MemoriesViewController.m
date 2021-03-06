//
//  MemoriesViewController.m
//  CSFamilyConnections
//
//  Created by vineeth on 6/4/17.
//  Copyright © 2017 Sanvis Health. All rights reserved.
//

#import "MemoriesViewController.h"
#import "MemoriesDetailViewController.h"
@interface MemoriesViewController ()

@end

@implementation MemoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.memoriesTableview.delegate=self;
    self.memoriesTableview.dataSource=self;
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;

    [self getMemoriesService];
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    

    
}


-(void)viewDidAppear:(BOOL)animated
{
    
}
-(void)getMemoriesService
{
    [indicator startAnimating];
    NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://sbmayur.com/Homepage/getproducts"]];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"GET"];
    
    //Pass some default parameter(like content-type etc.)
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //Now pass your own parameter
    
    
    /*  NSError *theError = NULL;
     NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
     NSMutableArray *dataResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
     NSLog(@"url to send request= %@",theURL);
     NSLog(@"Message response%@",dataResponse);
     self.contentArray = [[NSMutableArray alloc]init];
     [self.contentArray addObjectsFromArray:dataResponse];
     [self.messageTableview reloadData];*/
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async (dispatch_get_main_queue(), ^{
         
         // NSMutableArray *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
         // NSString *outputString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self->indicator stopAnimating];
             NSError *theError = NULL;
             NSMutableArray *dataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&theError];
             NSLog(@"url to send request= %@",theURL);
             NSLog(@"Memories response%@",dataResponse);
             self.contentArray = [[NSMutableArray alloc]init];
             [self.contentArray addObjectsFromArray:[dataResponse valueForKey:@"products"]];
             [self.memoriesTableview reloadData];
            
         });
         
         //  NSLog(@"Delete webresponse=%@",res);
         
         
         
         
         
        });
        
    }] resume];
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50)];
    headerView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1.0f];
    // headerView.layer.borderColor=[UIColor blackColor].CGColor;
    // headerView.layer.borderWidth=1.0f;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0,50,headerView.frame.size.height)];
    
   
    headerLabel.text = @"Date";
    headerLabel.textColor=[UIColor blackColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = [UIColor clearColor];
    [headerLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    
    [headerView addSubview:headerLabel];
    
    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(headerView.center.x - 50, 0, 100.0, headerView.frame.size.height)];
    
    headerLabel1.textAlignment = NSTextAlignmentCenter;
    headerLabel1.text = @"Comment";
    //headerLabel1.textColor=[UIColor grayColor];
    //[headerLabel1 setFont:[UIFont systemFontOfSize:14]];
    headerLabel1.textColor=[UIColor blackColor];
    [headerLabel1 setFont:[UIFont boldSystemFontOfSize:16.0f]];
    headerLabel1.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:headerLabel1];
    
    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width-65.0, 0, 50.0, headerView.frame.size.height)];
    
    headerLabel2.textAlignment = NSTextAlignmentCenter;
    headerLabel2.text = @"Photo";
   // headerLabel2.textColor=[UIColor grayColor];
   // [headerLabel2 setFont:[UIFont systemFontOfSize:14]];
     headerLabel2.textColor=[UIColor blackColor];
    [headerLabel2 setFont:[UIFont boldSystemFontOfSize:16.0f]];
    headerLabel2.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:headerLabel2];

    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"memorycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row%2 == 0)
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    else{
        cell.backgroundColor=[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0] ;
        
    }
   
    UILabel *Date= (UILabel*)[cell viewWithTag:1];
  //  Date.text = [[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"Date"];
    UILabel *subject= (UILabel*)[cell viewWithTag:2];
    if([[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"product_name"] != nil)
    {
    subject.text = [[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"product_name"];
    } else {
        subject.text = @"No Product";
    }
    UILabel *MessageContent= (UILabel*)[cell viewWithTag:4];
    if([[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"Message"] != nil)
    {
        MessageContent.text = [[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"Message"];
    }
    MessageContent.text = @"";
    UIImageView *profimg = (UIImageView *)[cell viewWithTag:3];
    profimg.image = [UIImage imageNamed:@""];//headshot-placeholder
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://sbmayur.com/uploads/%@", [[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"p_image"]]];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(image != nil)
            {
                profimg.image = image;
            }
            
            
        });
    });

    // cell.textLabel.text = [NSString stringWithFormat:@"Item %d", indexPath.row];
    //  cell.textLabel.text = [self.contentArray objectAtIndex:indexPath.row];
    
    return cell;
    
    /*  NSString *cellID1=@"menucell";
     NSString *cellID2=@"submenucell";
     
     UITableViewCell *cell = nil;
     
     if (3 == indexPath.row) {
     
     cell =[tableView dequeueReusableCellWithIdentifier:cellID1];
     if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
     }
     // cell.textLabel.text = @"New Cell";
     
     }
     
     else
     {
     cell =[tableView dequeueReusableCellWithIdentifier:cellID2];
     if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
     }
     //cell.imageView.image = [UIImage imageNamed:@"Test.jpg"];
     }
     return cell;*/
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MemoriesDetailViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Memorydetail"];
    ViewController.imgURL = [NSString stringWithFormat:@"https://sbmayur.com/uploads/%@", [[self.contentArray objectAtIndex:indexPath.row] valueForKey:@"p_image"]];
   /* NSDictionary *passvalue = [self.contentArray objectAtIndex:indexPath.row];
    ViewController.passdict =[[NSMutableDictionary alloc]init];
    ViewController.passdict = [self.contentArray objectAtIndex:indexPath.row];*/
    [self.navigationController pushViewController:ViewController animated:NO];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)compose_messageClick:(id)sender {
    
    
}
- (IBAction)menu_ButtonClick:(id)sender {
  /*  [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];*/
    [self.navigationController popViewControllerAnimated:NO];
    
}@end
