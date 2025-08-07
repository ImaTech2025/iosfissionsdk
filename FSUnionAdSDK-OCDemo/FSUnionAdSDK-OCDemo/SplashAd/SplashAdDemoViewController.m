//
//  SplashAdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/18.
//

#import "SplashAdDemoViewController.h"
#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

@interface SplashAdDemoViewController ()<FSSplashAdDelegate>
{
    BOOL _loadAndShow;
}
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (nonatomic, strong) FSSplashAd *splashAd;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation SplashAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, UIScreen.mainScreen.bounds.size.height * 0.2)];
        _bottomView.backgroundColor = UIColor.greenColor;
    }
    return _bottomView;
}

#pragma mark - private
- (void)_loadAd {
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:self.slotIDTextField.text type:FSAdTypeSplash];
    self.splashAd = [[FSSplashAd alloc] initWithSlot:slot];
    self.splashAd.delegate = self;
    [self.splashAd loadAdData];
}

- (void)_showAd {
    [self.splashAd showSplashIn:UIApplication.sharedApplication.keyWindow.rootViewController bottomView:self.bottomView];
}

#pragma mark - IBAction
- (IBAction)loadButtonClick:(UIButton *)sender {
    _loadAndShow = NO;
    
    self.showButton.enabled = NO;
    
    [self _loadAd];
}

- (IBAction)showButtonClick:(UIButton *)sender {
    [self _showAd];
}

- (IBAction)loadAndShowButtonClick:(UIButton *)sender {
    _loadAndShow = YES;
    
    self.showButton.enabled = NO;
    
    [self _loadAd];
}


#pragma mark - FSSplashAdDelegate
- (void)fs_splashAdLoadSuccess:(FSSplashAd *)ad {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdLoadFailed:(FSSplashAd *)ad error:(NSError *)error {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdMaterialDownloadSuccess:(FSSplashAd *)ad {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
    if (_loadAndShow) {
        [self _showAd];
    } else {
        self.showButton.enabled = YES;
    }
}

- (void)fs_splashAdMaterialDownloadFailed:(FSSplashAd *)ad error:(NSError *)error {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdWillPresent:(FSSplashAd *)ad {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdFailedToPresent:(FSSplashAd *)ad error:(NSError *)error {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdDidVisible:(FSSplashAd *)ad {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdDidClick:(FSSplashAd *)ad {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
}

- (void)fs_splashAdDidClose:(FSSplashAd *)ad closeType:(enum FSSplashAdCloseType)closeType {
    NSLog(@"splashAdDemo: %s",__FUNCTION__);
    self.splashAd = nil;
    self.showButton.enabled = NO;
}

@end
