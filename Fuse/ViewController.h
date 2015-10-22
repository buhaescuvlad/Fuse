//
//  ViewController.h
//  Fuse
//
//  Created by Vlad - Constantin on 21/10/2015.
//  Copyright © 2015 Vlad - Constantin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"

#define kUrlFirstPart @"https://"
#define kUrlSecondPart @".fusion-universal.com/api/v1/company.json"

@interface ViewController : UIViewController<UITextFieldDelegate>

-(void)handleRequestWithCompanyName:(NSString *)companyName;
-(void)generateAlertWithMessage:(NSString*)message andTitle:(NSString*)title;

@end

