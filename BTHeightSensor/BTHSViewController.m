//
//  BTHSViewController.m
//  BTHeightSensor
//
//  Created by Albertino Padin on 4/6/13.
//  Copyright (c) 2013 Albertino Padin. All rights reserved.
//

#import "BTHSViewController.h"
#import "EMFramework.h"

@interface BTHSViewController ()

@end

@implementation BTHSViewController

@synthesize connectionLabel, distanceTF, readDistButton, led2Switch, connectionIndicator, connListView;

- (void)viewWillAppear:(BOOL)animated
{
    self.connectionIndicator.classForPopover = [self.connListView class];
    [[EMConnectionListManager sharedManager] addObserver:self forKeyPath:@"devices" options:NSKeyValueObservingOptionInitial context:NULL];
    
    [[EMConnectionManager sharedManager] setBackgroundUpdatesEnabled:YES];
    [[EMConnectionManager sharedManager] addObserver:self forKeyPath:@"connectionState" options:NSKeyValueObservingOptionInitial context:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // observe changes to the connection state
    //[[EMConnectionManager sharedManager] addObserver:self forKeyPath:@"connectionState" options:NSKeyValueObservingOptionNew context:NULL];
    
    // observe changes to the available devices for connection
    //[[EMConnectionListManager sharedManager] addObserver:self forKeyPath:@"devices" options:NSKeyValueObservingOptionNew context:NULL];
    
    //connManager = [EMConnectionManager sharedManager];
    
    self.connListView.actualFrame = self.connListView.frame;
    
    [self disableControls];
    
//    [[EMConnectionListManager sharedManager] addObserver:self forKeyPath:@"devices" options:NSKeyValueObservingOptionInitial context:NULL];
//    
//    [[EMConnectionManager sharedManager] setBackgroundUpdatesEnabled:YES];
//    [[EMConnectionManager sharedManager] addObserver:self forKeyPath:@"connectionState" options:NSKeyValueObservingOptionInitial context:NULL];
    
}

- (void)disableControls
{
    self.led2Switch.userInteractionEnabled = NO;
//    self.led2Switch.onTintColor = [UIColor grayColor];
//    self.led2Switch.thumbTintColor = [UIColor grayColor];
    self.led2Switch.alpha = 0.4;
    self.readDistButton.userInteractionEnabled = NO;
//    [self.readDistButton setTitleColor:[UIColor grayColor] forState:nil];
//    [self.readDistButton setTintColor:[UIColor grayColor]];
    self.readDistButton.alpha = 0.4;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"In observeValueForKeyPath");
    NSLog(@"Object is: %@", object);
    
    if (object == [EMConnectionListManager sharedManager]) {
        // Handle a new set of devices coming available.
        if ([[EMConnectionListManager sharedManager] devices].count > 0  &&  [[EMConnectionManager sharedManager] connectionState] != EMConnectionStateConnected)
        {
            connectionLabel.text = [NSString stringWithFormat:@"Detected a device named: %@", [[[[EMConnectionListManager sharedManager] devices] objectAtIndex:0] name]];
        }
        
    }
//    else if (object == [EMConnectionManager sharedManager]) {
    if (object == [EMConnectionManager sharedManager]) {
        switch ([[EMConnectionManager sharedManager] connectionState]) {
                
            case EMConnectionStatePending:
                EMLog(@"Connecting to device");
                // the connection has started.  This is a good time to update you UI to reflect a pending connection
                connectionLabel.text = @"Connecting to device";
                [self disableControls];
                break;
                
            case EMConnectionStateDisconnected:
                EMLog(@"Successful disconnect");
                // Handle a successfully terminated connection
                connectionLabel.text = @"Successful disconnect";
                [self disableControls];
                break;
                
            case EMConnectionStateConnected:
                EMLog(@"Successful connection");
                // Handle a successful connection
                connectionLabel.text = @"Successful connection";
                self.readDistButton.userInteractionEnabled = YES;
                //[self.readDistButton setTintColor:[UIColor whiteColor]];
                //[self.readDistButton setTitleColor:[UIColor blueColor] forState:nil];
                self.readDistButton.alpha = 1.0;
                self.led2Switch.userInteractionEnabled = YES;
                //self.led2Switch.thumbTintColor = [UIColor whiteColor];
                //self.led2Switch.onTintColor = [UIColor blueColor];
                self.led2Switch.alpha = 1.0;
                break;
                
            case EMConnectionStateDisrupted:
                EMLog(@"Connection interrupted");
                // Handle a disrupted connection
                connectionLabel.text = @"Connection interrupted";
                [self disableControls];
                break;
                
            case EMConnectionStateInvalidSchemaHash:
                EMLog(@"Invalid Schema Hash");
                // The schema could not be read
                connectionLabel.text = @"Invalid Schema Hash";
                [self disableControls];
                break;
                
            case EMConnectionStateSchemaNotFound:
                EMLog(@"No schema found");
                // You have not included the schema for this connection in your application bundle.
                connectionLabel.text = @"No schema found";
                [self disableControls];
                break;
                
            case EMConnectionStateTimeout:
                EMLog(@"Connection timeout");
                // The connection timed out
                connectionLabel.text = @"Connection timeout";
                [self disableControls];
                break;
                
            default:
                NSLog(@"WTF, EMConnectionState is: %u", [[EMConnectionManager sharedManager] connectionState]);
                [self disableControls];
                break;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  This is already taken care of by the connection indicator class (connecting to the device)

//- (IBAction)connectToHeightSensor:(id)sender
//{
//    NSLog(@"Button Pressed");
//    // observe changes to the connection state
//    //[[EMConnectionManager sharedManager] addObserver:self forKeyPath:@"connectionState" options:NSKeyValueObservingOptionNew context:NULL];
//        // observe changes to the available devices for connection
//    //[[EMConnectionListManager sharedManager] addObserver:self forKeyPath:@"devices" options:NSKeyValueObservingOptionInitial context:NULL];
//    
////    [[EMConnectionManager sharedManager] setBackgroundUpdatesEnabled:YES];
////    [[EMConnectionManager sharedManager] addObserver:self forKeyPath:@"connectionState" options:NSKeyValueObservingOptionInitial context:NULL];
//    
//    
////    EMConnectionManager *connectionManager = [EMConnectionManager sharedManager];
////    EMConnectionListManager *connListMan = [EMConnectionListManager sharedManager];
////    [connListMan addConnectionTypeToUpdates:[[EMBluetoothLowEnergyConnectionType alloc] init]];
////    [connListMan startUpdating];
////    
////    while ([connListMan isUpdating]) {
////        //Wait
////    }
////    
//    EMDeviceBasicDescription *heightSensorDevice = [[EMConnectionListManager sharedManager] deviceBasicDescriptionForDeviceNamed:@"EDB-1E-85-6B"];
//    //EMDeviceBasicDescription *heightSensorDevice = [[EMDeviceBasicDescription alloc] init];
//    //heightSensorDevice.name = @"EDB-1E-85-6B";
//    //heightSensorDevice.connectionType = [[EMBluetoothLowEnergyConnectionType alloc] init];
//    //heightSensorDevice.deviceObject = [[CBPeripheral alloc] init];
//    //heightSensorDevice.deviceObject = [[CBPeripheralManager alloc] init];
//    
//    //EMConnection *connection = [[EMConnection alloc] initWithDevice:heightSensorDevice];
//    
//    void (^successBlock)(void) = ^(void)
//    {
//        connectionLabel.text = @"Connected!!!";
//    };
//    
//    void (^failBlock)(NSError *) = ^(NSError *connectError)
//    {
//        NSLog(@"Connection Error: %@", connectError);
//        connectionLabel.text = @"Could not connect";
//    };
//
//    
//    [[EMConnectionManager sharedManager] connectDevice:heightSensorDevice onSuccess:successBlock onFail:failBlock];
//    
//}

- (IBAction)readDistance:(id)sender
{
    if ([[EMConnectionManager sharedManager] connectionState] != EMConnectionStateConnected) {
        return;
    }
    
    [[EMConnectionManager sharedManager] readResource:@"distance" onSuccess:^(id readValue) {
            
        //NSData *readData = (NSData *)readValue;
        distanceTF.text = [NSString stringWithFormat:@"%i",[readValue intValue]];
        
    } onFail:^(NSError *error) {
        EMLog(@"Failed to read distance");
    }];

}
- (IBAction)ledOnOrOff:(id)sender
{
    if ([[EMConnectionManager sharedManager] connectionState] != EMConnectionStateConnected) {
        return;
    }
    
    if ([sender isOn])
    {
        [[EMConnectionManager sharedManager] writeValue:@"LED2_ON" toResource:@"led2" onSuccess:^{
            // LED2 should be on
            
        } onFail:^(NSError *error) {
            EMLog(@"Failed to write led2");
        }];
    }
    else
    {
        [[EMConnectionManager sharedManager] writeValue:@"LED2_OFF" toResource:@"led2" onSuccess:^{
            // LED2 should be off
            
        } onFail:^(NSError *error) {
            EMLog(@"Failed to write led2");
        }];

    }
}
@end
