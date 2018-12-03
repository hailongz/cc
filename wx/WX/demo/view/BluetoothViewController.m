//
//  BluetoothViewController.m
//  demo
//
//  Created by zuowu on 2018/11/27.
//  Copyright © 2018 kkmofang.cn. All rights reserved.
//

#import "BluetoothViewController.h"
#import "ViewController.h"

#define DEVICE_UUID @"633A275D-F798-B03C-E088-10B8C184E94C"
#define S_ID @"FEBE"
#define C_ID @"9EC813B4-256B-4090-93A8-A4F0E9107733"
//#define C_ID @"234BFBD5-E3B3-4536-A3FE-723620D4B78D"

@interface BluetoothViewController ()

@end

@implementation BluetoothViewController
- (IBAction)btnOpenBluetooth:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXBOpenBluetoothAdapterObject * object = [[WXBOpenBluetoothAdapterObject alloc] init];
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"OpenBluetoothAdapter success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"OpenBluetoothAdapter fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"OpenBluetoothAdapter complete res = %@", res);
    };
    [wx openBluetoothAdapter:object];
}
- (IBAction)btnCloseBluetooth:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXCloseBluetoothAdapterObject * object = [[WXCloseBluetoothAdapterObject alloc] init];
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"CloseBluetoothAdapter success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"CloseBluetoothAdapter fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"CloseBluetoothAdapter complete res = %@",res);
    };
    [wx closeBluetoothAdapter:object];
}
- (IBAction)btnStartBluetoothDevicesDiscovery:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXStartBluetoothDevicesDiscoveryObject * object = [[WXStartBluetoothDevicesDiscoveryObject alloc] init];
//    object.interval = 5000;
//    object.services = @[@"181D"];
//    object.allowDuplicatesKey = NO;
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"StartBluetoothDevicesDiscovery success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"StartBluetoothDevicesDiscovery fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"StartBluetoothDevicesDiscovery complete res = %@", res);
    };
    
    wx.onBluetoothDeviceFound = ^(id<WXOnBluetoothDeviceFoundRes> res) {

//        NSLog(@"found devices\n");
//        NSLog(@"%@",res);
    };
    
    [wx startBluetoothDevicesDiscovery:object];
    
}
- (IBAction)btnStopBluetoothDevicesDiscovery:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXStopBluetoothDevicesDiscoveryObject * object = [[WXStopBluetoothDevicesDiscoveryObject alloc] init];
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"StopBluetoothDevicesDiscovery success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"StopBluetoothDevicesDiscovery fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"StopBluetoothDevicesDiscovery complete res = %@", res);
    };
    [wx stopBluetoothDevicesDiscovery:object];
}
- (IBAction)btnGetBluetoothDevices:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXGetBluetoothDevicesObject * object = [[WXGetBluetoothDevicesObject alloc] init];
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXGetBluetoothDevicesObject success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXGetBluetoothDevicesObject fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXGetBluetoothDevicesObject complete res = %@", res);
    };
    [wx getBluetoothDevices:object];
}
- (IBAction)btnGetConnectBluetoothDevices:(id)sender {
}



- (IBAction)btnCreateBLEConnection:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXCreateBLEConnectionObject * object = [[WXCreateBLEConnectionObject alloc] init];
 
    object.deviceId = DEVICE_UUID;
//    object.timeout = 1000;
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXCreateBLEConnectionObject success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXCreateBLEConnectionObject fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXCreateBLEConnectionObject complete res = %@", res);
    };
    [wx createBLEConnection:object];
}
- (IBAction)btnCloseBLEConnection:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXCloseBLEConnectionObject * object = [[WXCloseBLEConnectionObject alloc]init];
    object.deviceId = DEVICE_UUID;
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXCloseBLEConnectionObject success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXCloseBLEConnectionObject fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXCloseBLEConnectionObject complete res = %@", res);
    };
    [wx closeBLEConnection:object];
}
- (IBAction)btbGetBLEDevicesServices:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXGetBLEDeviceServicesObject * object = [[WXGetBLEDeviceServicesObject alloc]init];
    object.deviceId = DEVICE_UUID;
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXGetBLEDeviceServicesObject success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXGetBLEDeviceServicesObject fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"WXGetBLEDeviceServicesObject complete res = %@", res);
    };
    [wx getBLEDeviceServices:object];
    
}
- (IBAction)BtnGetBLEDevicesCharacteristics:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXBGetLEDeviceCharacteristicsObject * object = [[WXBGetLEDeviceCharacteristicsObject alloc] init];
    object.deviceId = DEVICE_UUID;
    object.serviceId = S_ID;
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"BtnGetBLEDevicesCharacteristics success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"BtnGetBLEDevicesCharacteristics fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"BtnGetBLEDevicesCharacteristics complete res = %@", res);
    };
    [wx getBLEDeviceCharacteristics:object];
}
- (IBAction)btnNotifyBLECharacteristicValueChange:(id)sender {
    WX * wx = [ViewController getInstance].wx;
    WXNotifyBLECharacteristicValueChangeObject * object = [[WXNotifyBLECharacteristicValueChangeObject alloc] init];
    object.deviceId = DEVICE_UUID;
    object.serviceId = S_ID;
    object.characteristicId = C_ID;
    object.state = YES;
    object.success = ^(id<WXBluetoothRes> res) {
        NSLog(@"NotifyBLECharacteristicValueChange success res = %@", res);
    };
    object.fail = ^(id<WXBluetoothRes> res) {
        NSLog(@"NotifyBLECharacteristicValueChange fail res = %@", res);
    };
    object.complete = ^(id<WXBluetoothRes> res) {
        NSLog(@"NotifyBLECharacteristicValueChange complete res = %@", res);
    };
    [wx notifyBLECharacteristicValueChange:object];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
