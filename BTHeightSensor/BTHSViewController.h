//
//  BTHSViewController.h
//  BTHeightSensor
//
//  Created by Albertino Padin on 4/6/13.
//  Copyright (c) 2013 Albertino Padin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMConnectionIndicator.h"
#import "CLV.h"

@interface BTHSViewController : UIViewController

// NOPE. MUST ACCESS THROUGH CLASS METHOD
//@property (strong, nonatomic) EMConnectionManager *connectionManager;

@property (strong, nonatomic) IBOutlet UILabel *connectionLabel;
@property (strong, nonatomic) IBOutlet UITextField *distanceTF;
@property (strong, nonatomic) IBOutlet UISwitch *led2Switch;
@property (strong, nonatomic) IBOutlet UIButton *readDistButton;
@property (strong, nonatomic) IBOutlet EMConnectionIndicator *connectionIndicator;
@property (strong, nonatomic) IBOutlet CLV *connListView;

- (IBAction)ledOnOrOff:(id)sender;

//- (IBAction)connectToHeightSensor:(id)sender;
- (IBAction)readDistance:(id)sender;

@end
