//
//  RewardedVideoAdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/11/18.
//

#import "RewardedVideoAdDemoViewController.h"
#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

@interface RewardedVideoAdDemoViewController ()<FSRewardedAdDelegate>

@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;

@property (weak, nonatomic) IBOutlet UIButton *showButton;

@property (weak, nonatomic) IBOutlet UIButton *loadButton;

@property (nonatomic, strong) FSRewardedAd *rewardedAd;

@end

@implementation RewardedVideoAdDemoViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loadButtonClick:(UIButton *)sender {
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:self.slotIDTextField.text type:FSAdTypeReward];
    FSRewardedAd *rewardedAd = [[FSRewardedAd alloc] initWithSlot:slot];
    rewardedAd.delegate = self;
    [rewardedAd loadAdData];
    self.rewardedAd = rewardedAd;
}

- (IBAction)showButtonClick:(UIButton *)sender {
    sender.enabled = NO;
    [self.rewardedAd showAdFromRootViewController:self];
}

// MARK: - FSRewardedAdDelegate
- (void)fs_rewardedAdDidLoadSuccess:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
    self.showButton.enabled = YES;
}

- (void)fs_rewardedAd:(FSRewardedAd *)ad didLoadFailedWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAdDidDownloadMaterial:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAd:(FSRewardedAd *)ad didRenderFailedWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAdDidVisible:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAdDidSkip:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAdDidClick:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAdDidClose:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
}

- (void)fs_rewardedAdDidSucceed:(FSRewardedAd *)ad {
    NSLog(@"%s", __FUNCTION__);
}

@end
