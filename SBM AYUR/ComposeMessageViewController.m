//
//  ComposeMessageViewController.m
//  CSMessenger
//
//  Created by imagiNETVentures on 10/02/17.
//  Copyright © 2017 imaginet. All rights reserved.
//

#import "ComposeMessageViewController.h"
#import "Config.h"
@interface ComposeMessageViewController ()

@end

@implementation ComposeMessageViewController
@synthesize categoryPickerView;
@synthesize dataArray;
int tagselected;

NSString *FacilityStaffID;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.message_txtview.layer.borderWidth = 1.0f;
    self.message_txtview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.totextextfield.delegate = self;
    self.subjecttextfield.delegate = self;
    self.message_txtview.delegate = self;
    // Do any additional setup after loading the view.
    if(self.passdict.count > 0)
    {
        self.totextextfield.text = [self.passdict valueForKey:@"Staffname"];
         self.subjecttextfield.text = [self.passdict valueForKey:@"Subject"];
        self.totextextfield.userInteractionEnabled = NO;
        self.subjecttextfield.userInteractionEnabled = NO;
      FacilityStaffID =  [NSString stringWithFormat:@"%@",[self.passdict valueForKey:@"SenderID"]];
        UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        pickerToolbar.barStyle = UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(categoryDoneButtonPressed)];
        
       
        
        [pickerToolbar setItems:@[flexSpace, flexSpace, doneBtn] animated:YES];
        self.totextextfield.inputView = categoryPickerView;
        self.totextextfield.inputAccessoryView = pickerToolbar;
        // self.subjecttextfield.inputView = categoryPickerView;
        self.subjecttextfield.inputAccessoryView = pickerToolbar;
        self.message_txtview.inputAccessoryView = pickerToolbar;
    }
    else
    {
  
    }
    
   
   
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField == self.subjecttextfield)
    {
   // CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y+120);
   // [self.scrollview setContentOffset:scrollPoint animated:YES];
    }
    if (textField.tag == 1) {
        tagselected = 1;
        [categoryPickerView reloadAllComponents];
        //this is textfield 2, so call your method here
    }
    /*else if (textField.tag == 2)
    {
        tagselected = 2;
         [categoryPickerView reloadAllComponents];
    }*/
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //handle user taps text view to type text
    
    CGPoint scrollPoint = CGPointMake(0, textView.frame.origin.y);
    [self.scrollview setContentOffset:scrollPoint animated:YES];

}
- (void)textViewDidEndEditing:(UITextView *)textView {
    //handle text editing finished
     [self.scrollview setContentOffset:CGPointZero animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollview setContentOffset:CGPointZero animated:YES];
}

-(void)setcustomPickerView:(NSMutableArray *)content
{
    dataArray = [[NSMutableArray alloc] init];
    [dataArray addObjectsFromArray:content];
    // Add some data for demo purposes.
  /*  [dataArray addObject:@"One"];
    [dataArray addObject:@"Two"];
    [dataArray addObject:@"Three"];
    [dataArray addObject:@"Four"];
    [dataArray addObject:@"Five"];*/
    
   
    
    categoryPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    
    [categoryPickerView setDataSource: self];
    [categoryPickerView setDelegate: self];
    categoryPickerView.showsSelectionIndicator = YES;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(categoryDoneButtonPressed)];
    
   
    
    [pickerToolbar setItems:@[flexSpace, flexSpace, doneBtn] animated:YES];
    self.totextextfield.inputView = categoryPickerView;
    self.totextextfield.inputAccessoryView = pickerToolbar;
   // self.subjecttextfield.inputView = categoryPickerView;
    self.subjecttextfield.inputAccessoryView = pickerToolbar;
     self.message_txtview.inputAccessoryView = pickerToolbar;
    //[pickerViewPopup addSubview:pickerToolbar];
    //[pickerViewPopup addSubview:categoryPickerView];
   // [pickerViewPopup showInView:self.view];
    //[pickerViewPopup setBounds:CGRectMake(0,0,320, 464)];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    
    NSLog(@"%@",[dataArray objectAtIndex:row]);
    if(tagselected == 1)
    {
        self.totextextfield.text = [NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:row] valueForKey:@"StaffName"]];
        FacilityStaffID =  [NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:row] valueForKey:@"FacilityStaffID"]];

    }
    else
    {
        self.subjecttextfield.text = [NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:row] valueForKey:@"StaffTitle"]];
    }
   // selectedCategory = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:row]];
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
     NSLog(@"datacount%lu",(unsigned long)[dataArray count]);
    return [dataArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(tagselected == 1)
    {
        return [[dataArray objectAtIndex:row] valueForKey:@"StaffName"];
        
    }
    else
    {
        return [[dataArray objectAtIndex:row] valueForKey:@"StaffTitle"];
    }
 
 //   return [dataArray objectAtIndex: row];
    
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

-(void)categoryDoneButtonPressed{
    [self.totextextfield resignFirstResponder];
    [self.subjecttextfield resignFirstResponder];
    [self.message_txtview resignFirstResponder];
   // categoryLable.text = selectedCategory;
    
}

-(void)categoryCancelButtonPressed{
   // [pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
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

- (IBAction)sendButtonClick:(id)sender {
    if(self.totextextfield.text.length == 0)
    {
        [uAppDelegate showMessage:@"Please choose a receipient address" withTitle:@"Message"];
        return;
    }
    else if (self.subjecttextfield.text.length == 0)
    {
       
        [uAppDelegate showMessage:@"Please enter a subject" withTitle:@"Message"];
        return;
    }
    else
    {

    [self sendmessagemethod];
    }
}
-(void)sendmessagemethod
{
   
    NSMutableDictionary *post = [[NSMutableDictionary alloc]init];
    [post setValue:@"vineethsreekumar25@gmail.com" forKey:@"Email"];
    [post setValue:self.message_txtview.text forKey:@"description"];
   
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:post options:kNilOptions error:&writeError];

    NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
    NSString *urlstring = [NSString stringWithFormat:@"https://sbmayur.com/Homepage/enquiry"];
    [urlrequest setURL:[NSURL URLWithString:urlstring]];
   
    [urlrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];


    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:jsonData];
    [[[NSURLSession sharedSession] dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {

         NSError *error1;
         NSMutableArray *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
      //   NSString *outputString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         NSLog(@"message webresponse=%@",res);
         dispatch_async(dispatch_get_main_queue(), ^{
            
            
           

            [uAppDelegate showMessage:@"Message Send Successfully" withTitle:@"Message"];
             
         });

        
     
    }] resume];
    
}

- (IBAction)menu_ButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
  
}
@end
