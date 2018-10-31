//
//  KKPageViewController.h
//  KK
//
//  Created by hailong11 on 2018/10/31.
//  Copyright © 2018年 kkmofang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KK/KKPage.h>
#import <KK/KKApp.h>

@interface KKPageViewController : UIViewController

@property(nonatomic,strong) KKApp * app;
@property(nonatomic,strong) NSString * path;
@property(nonatomic,strong,readonly) KKPage * page;
@property(nonatomic,strong) NSDictionary<NSString *,NSString *> * query;

@end