//
//  ViewController.m
//  GLNumPad
//
//  Created by GrayLand on 16/1/7.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "ViewController.h"
#import "GLNumPadView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    textF.borderStyle = UITextBorderStyleRoundedRect;
    
    GLNumPadView *numPadView = [[GLNumPadView alloc] initWithEventBlock:^(GLNumPadEvent event, NSString *inputString) {
        
        switch (event) {
            case GLNumPadEventOnNum:
            {
                textF.text = [NSString stringWithFormat:@"%@%@", textF.text, inputString];
            }break;
                
            case GLNumPadEventOnBackspace:
            {
                textF.text = [textF.text substringToIndex:textF.text.length >= 1 ? textF.text.length - 1 : 0];
            }break;
                
            case GLNumPadEventOnFinish:
            {
                [textF resignFirstResponder];
            }break;
                
            case GLNumPadEventOnDone:
            {
                [textF resignFirstResponder];
            }break;
        }
    }];
    
    textF.inputView = numPadView;
    [self.view addSubview:textF];
}


- (void)onKeyBoardWillShow:(NSNotification *)notification
{
    NSLog(@"onKeyBoardWillShow");
}
@end
