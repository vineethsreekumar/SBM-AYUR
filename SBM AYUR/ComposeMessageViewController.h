//
//  ComposeMessageViewController.h
//  CSMessenger
//
//  Created by imagiNETVentures on 10/02/17.
//  Copyright © 2017 imaginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeMessageViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate> {
   
    UIPickerView *categoryPickerView;
    UIPickerView *pickerView;
    NSMutableArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *totextextfield;
@property (weak, nonatomic) IBOutlet UITextField *subjecttextfield;

@property (weak, nonatomic) IBOutlet UITextView *message_txtview;


@property (nonatomic, retain) UIPickerView *categoryPickerView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (strong,nonatomic) NSString * passtype;
@property (strong,nonatomic) NSMutableDictionary * passdict;
- (IBAction)sendButtonClick:(id)sender;
- (IBAction)menu_ButtonClick:(id)sender;

@end
