

#import "AboutViewController.h"
@interface AboutViewController ()
- (IBAction)callButtonClick:(id)sender;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *websiteUrl = [NSURL URLWithString:@"https://www.sanvishealth.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webview loadRequest:urlRequest];
    [self.webview loadHTMLString:@"SBM AYUR is a G.M.P. and ISO 9001-2000 certified company estab¬lished in 2004 by Dr. Sreedevi. The enterprise has enjoyed stunning yet steady growth in the pharmaceutical industry in this short time. SBM has manufacturing units in south and north India to meet any global demands for industry yielding the best natural products. The visionary behind these achievements is Dr. Sreedevi, a naturalist and scientist who spent many years in direct interaction with rural communities to learn ancient tribal formulae and natural medicinal secrets.<\/p>\n               <p>It is really astonishing to realize that scientist Dr. Sreedevi and her products have become a household name. SBM has a very strong presence in India; USA, Canada & GCC and SBM AYUR products are available in all consumer shops now in these Countries. Aggressive marketing plans has set out and commenced to penetrate to all major markets through out the world from the current year onwards." baseURL:nil];


    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{    //[self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.sanvishealth.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu_ButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)callButtonClick:(id)sender {
    NSString *phNo = @"+918547554075";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
     UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
