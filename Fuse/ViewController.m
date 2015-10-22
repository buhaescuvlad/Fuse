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
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *theUrl =[NSString stringWithFormat:@"%@%@%@",kUrlFirstPart,self.textField.text,kUrlSecondPart];
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
             UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:@"Request To Server went wrong"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
            
             UIAlertAction* ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:nil];
             [alert addAction:ok]; // add action to uialertcontroller
              [self presentViewController:alert animated:YES completion:nil];
             
         }];
    
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
