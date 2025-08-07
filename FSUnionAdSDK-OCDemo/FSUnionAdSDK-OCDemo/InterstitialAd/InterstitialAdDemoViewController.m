//
//  InterstitialAdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/18.
//

#import "InterstitialAdDemoViewController.h"
#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

@interface InterstitialAdDemoViewController ()<FSInterstitialAdDelegate>
{
    BOOL _loadAndShow;
    BOOL _muted;
}
@property (weak, nonatomic) IBOutlet UIButton *showADButton;
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;
@property (nonatomic, strong) FSInterstitialAd *ad;

@end

@implementation InterstitialAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loadAdButtonClick:(UIButton *)sender {
    _loadAndShow = NO;
    
    self.ad = nil;
    
    self.showADButton.enabled = NO;
    
    if (!self.slotIDTextField.text.length) {
        return;
    }
    
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:self.slotIDTextField.text type:FSAdTypeInterstitial];
    slot.timeout = 5.0;
    FSInterstitialAd *ad = [[FSInterstitialAd alloc] initWithSlot:slot];
    ad.videoMuted = _muted;
    ad.delegate = self;
    [ad loadAdData];
    self.ad = ad;
}

- (IBAction)showAdButtonClick:(UIButton *)sender {
    [self.ad showAdFromRootViewController:self];
    // Test: rootViewController is tabBarController
//    [self.ad showAdFromRootViewController:UIApplication.sharedApplication.keyWindow.rootViewController];
}

- (IBAction)loadAndShowButtonClick:(UIButton *)sender {
    _loadAndShow = YES;
    
    self.ad = nil;
    
    self.showADButton.enabled = NO;
    
    if (!self.slotIDTextField.text.length) {
        return;
    }
    
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:self.slotIDTextField.text type:FSAdTypeInterstitial];
    FSInterstitialAd *ad = [[FSInterstitialAd alloc] initWithSlot:slot];
    ad.videoMuted = _muted;
    ad.delegate = self;
    [ad loadAdData];
    self.ad = ad;
}

- (IBAction)changeMuteAction:(UISwitch *)sender {
    _muted = sender.on;
    self.ad.videoMuted = _muted;
}


#pragma mark - FSInterstitialAdDelegate
- (void)fs_interstitialAdSuccessToLoadAd:(FSInterstitialAd * _Nonnull)ad {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdFailedToLoadAd:(FSInterstitialAd * _Nonnull)ad error:(NSError * _Nonnull)error {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdSuccessToDwonlaodMaterial:(FSInterstitialAd *)ad {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
    if (_loadAndShow) {
        [ad showAdFromRootViewController:self];
    } else {
        self.showADButton.enabled = YES;
    }
}

- (void)fs_interstitialAdFailedToDwonlaodMaterial:(FSInterstitialAd *)ad error:(NSError *)error {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdRenderSuccess:(FSInterstitialAd *)ad {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdRenderFail:(FSInterstitialAd *)ad error:(NSError *)error {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdWillPresent:(FSInterstitialAd *)ad {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdDidVisible:(FSInterstitialAd * _Nonnull)ad {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
}

- (void)fs_interstitialAdDidClick:(FSInterstitialAd * _Nonnull)ad {
    NSLog(@"InterstitialAdDemo:%s interactionType:%ld", __FUNCTION__, ad.interactionType);
}

- (void)fs_interstitialAdDidClose:(FSInterstitialAd * _Nonnull)ad {
    NSLog(@"InterstitialAdDemo:%s", __FUNCTION__);
    self.showADButton.enabled = NO;
}

- (void)fs_interstitialAdDidCloseOtherController:(FSInterstitialAd *)ad interactionType:(enum FSAdInteractionType)interactionType {
    NSLog(@"InterstitialAdDemo:%s interactionType:%ld", __FUNCTION__, interactionType);
}

@end
