#一个简单的自定义数字键盘

##1. 使用说明
>使用Block代替代理事件,方便集中代码

>回调类型:
``` objectivec
typedef NS_ENUM(NSUInteger, GLNumPadEvent) {
    GLNumPadEventOnNum, // 点击数字
    GLNumPadEventOnDone, // 点击完成
    GLNumPadEventOnFinish, // 点击空白处和收起键盘按钮
    GLNumPadEventOnBackspace // 点击删除
};
```

``` objectivec
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

```
##其他
刚转行做IOS..练练手,写得不好的地方请勿见笑^.^~~

##效果图
![GLNumPadImage](https://github.com/GrayLand119/GLNumPad/blob/master/GLNumPadImg.jpg "GLNumPadImage")

