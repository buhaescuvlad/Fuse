//
//  ViewController.m
//  Fuse
//
//  Created by Vlad - Constantin on 21/10/2015.
//  Copyright © 2015 Vlad - Constantin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //here we do the job
    
    self.textField.delegate=self;
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)sender{
     self.textField.textColor=[UIColor whiteColor];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // done button was pressed - dismiss keyboard
    NSLog(@"dismiss keyboard");
    [textField resignFirstResponder];
    
    if ([textField.text isEqualToString:@""] || [textField.text isEqualToString:@" "]) {
        [self generateAlertWithMessage:@"Please insert a company name" andTitle:@"Text Field empty"];
    }
    else{
        [self handleRequestWithCompanyName:self.textField.text];
    }
    
    
    return YES;
}

-(void)handleRequestWithCompanyName:(NSString *)companyName
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *theUrl =[NSString stringWithFormat:@"%@%@%@",kUrlFirstPart,companyName,kUrlSecondPart];
    [manager GET:theUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger statusCode = operation.response.statusCode;
             NSLog(@"status CODE is %ld",(long)statusCode);
             if (statusCode == 200) {
                 NSLog(@"SUCCES!!!");
                 self.textField.textColor=[UIColor greenColor];
                 self.textField.text=[responseObject valueForKey:@"name"];
             }
             NSLog(@"JSON: %@ \n %@", [responseObject class] , responseObject);
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             self.textField.textColor=[UIColor redColor];
             
             NSLog(@"Error: %@", error);
             [self generateAlertWithMessage:@"Company does not Exist" andTitle:@"Sorry"];
             
         }];
}

-(void)generateAlertWithMessage:(NSString*)message andTitle:(NSString*)title
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:nil];
    [alert addAction:ok]; // add action to uialertcontroller
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
