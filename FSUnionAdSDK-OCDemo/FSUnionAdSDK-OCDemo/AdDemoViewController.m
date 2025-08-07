//
//  AdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/18.
//

#import "AdDemoViewController.h"

@interface AdDemoViewController ()

@property (weak, nonatomic) UITextField *slotIDTextField;

@end

@implementation AdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试广告位" style:UIBarButtonItemStylePlain target:self action:@selector(selectTestADID)];
}

- (void)selectTestADID {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择测试广告位" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray<NSString *> *adids = @[
        @"2_1_1#横版图片+LandingPage",
        @"2_1_3#横版图片+DEEPLINK",
        @"2_1_4#横版图片+WeChat",
        @"2_1_5#横版图片+AppStroe",
        @"2_2_1#竖版图片+LandingPage页",
        @"2_2_3#竖版图片+DEEPLINK",
        @"2_2_4#竖版图片+WeChat",
        @"2_2_5#竖版图片+AppStroe",
        @"2_3_1#横版视频+LandingPage",
        @"2_3_3#横版视频+DEEPLINK",
        @"2_3_4#横版视频片+WeChat",
        @"2_3_5#横版视频+AppStroe",
        @"2_4_1#竖版视频+LandingPage",
        @"2_4_3#竖版视频+DEEPLINK",
        @"2_4_4#竖版视频+WeChat",
        @"2_4_5#竖版视频+AppStroe"
    ];
    for (NSString *adidString in adids) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:adidString style:UIAlertActionStyleDefault   handler:^(UIAlertAction * _Nonnull action) {
            self.slotIDTextField.text = [adidString substringWithRange:NSMakeRange(0, 5)];
        }];
        [alertController addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.slotIDTextField resignFirstResponder];
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
