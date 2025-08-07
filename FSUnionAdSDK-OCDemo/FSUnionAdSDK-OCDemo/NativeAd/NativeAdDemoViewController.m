//
//  NativeAdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/18.
//

#import "NativeAdDemoViewController.h"

#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

#import <SDWebImage/SDWebImage.h>

@interface NativeAdDemoViewController ()<FSNativeAdsManagerDelegate, FSNativeAdDelegate, FSVideoAdViewDelegate>

@property (nonatomic, strong) FSNativeAdsManager *loadManager;

@property (nonatomic, strong) FSNativeAd *nativeAd;

@property (nonatomic, strong) FSNativeAdRelatedView *adRelatedView;

@property (nonatomic, strong) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;

@property (weak, nonatomic) IBOutlet UIButton *loadButton;

@property (weak, nonatomic) IBOutlet UIButton *showButton;

@property (weak, nonatomic) IBOutlet UIView *adContainer;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UIButton *replayButton;

@property (weak, nonatomic) IBOutlet UISwitch *autoPlaySwitch;

@property (weak, nonatomic) IBOutlet UISwitch *muteSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *autoReplaySwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *isVideoSegment;

@property (weak, nonatomic) IBOutlet UILabel *extraInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoWidthLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoHeightLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoSrcLabel;

@property (weak, nonatomic) IBOutlet UILabel *imageWidthLabel;

@property (weak, nonatomic) IBOutlet UILabel *imageHeightLabel;

@property (weak, nonatomic) IBOutlet UILabel *imageSrcLabel;

@property (weak, nonatomic) IBOutlet UILabel *dspInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *appInfoLabel;

@end

@implementation NativeAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.adRelatedView = [[FSNativeAdRelatedView alloc] init];
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

- (IBAction)loadButtonClick:(UIButton *)sender {
    self.loadButton.enabled = NO;
    [self load];
}


- (IBAction)showButtonClick:(UIButton *)sender {
    [self show];
    
    self.showButton.enabled = NO;
}

- (IBAction)playButtonClick:(id)sender {
    [self.adRelatedView.videoAdView play];
}

- (IBAction)pauseButtonClick:(id)sender {
    [self.adRelatedView.videoAdView pause];
}

- (IBAction)stopButtonClick:(id)sender {
//    [self.adRelatedView.videoAdView destroy];
}

- (IBAction)replayButtonClick:(id)sender {
    [self.adRelatedView.videoAdView replay];
}

- (IBAction)autoPlaySwitchClick:(UISwitch *)sender {
    self.adRelatedView.videoAdView.isVisibleAutoPlay = sender.on;
}

- (IBAction)muteSwitchClick:(UISwitch *)sender {
    self.adRelatedView.videoAdView.isMuted = sender.on;
}
- (IBAction)autoReplaySwitchClick:(UISwitch *)sender {
    self.adRelatedView.videoAdView.isAutoReplay = sender.on;
}

- (void)load {
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:self.slotIDTextField.text type:FSAdTypeNative];
    FSNativeAdsManager *loadManager = [[FSNativeAdsManager alloc] initWithSlot:slot];
    loadManager.delegate = self;
    [loadManager loadAd];
    self.loadManager = loadManager;
}

- (void)show {
    if (self.nativeAd.material.isVideo) {
        [self.adRelatedView refreshData:self.nativeAd];
        FSVideoAdView *videoAdView = self.adRelatedView.videoAdView;
        if (videoAdView) {
            videoAdView.delegate = self;
            videoAdView.isVisibleAutoPlay = self.autoPlaySwitch.on;
            videoAdView.isMuted = self.muteSwitch.on;
            videoAdView.isAutoReplay = self.autoReplaySwitch.on;
            
            videoAdView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.adContainer addSubview:videoAdView];
            [videoAdView.topAnchor constraintEqualToAnchor:self.adContainer.topAnchor].active = YES;
            [videoAdView.leftAnchor constraintEqualToAnchor:self.adContainer.leftAnchor].active = YES;
            [videoAdView.bottomAnchor constraintEqualToAnchor:self.adContainer.bottomAnchor].active = YES;
            [videoAdView.rightAnchor constraintEqualToAnchor:self.adContainer.rightAnchor].active = YES;
        }
    } else {
        self.imageView = [[UIImageView alloc] init];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.nativeAd.material.images.firstObject.url]];
        [self.adContainer addSubview:self.imageView];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.imageView.topAnchor constraintEqualToAnchor:self.adContainer.topAnchor].active = YES;
        [self.imageView.leftAnchor constraintEqualToAnchor:self.adContainer.leftAnchor].active = YES;
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.adContainer.bottomAnchor].active = YES;
        [self.imageView.rightAnchor constraintEqualToAnchor:self.adContainer.rightAnchor].active = YES;
    }
    
    [self.nativeAd registerContainer:self.adContainer withClickableViews:@[self.adContainer]];
    self.nativeAd.rootViewController = self;
    self.nativeAd.delegate = self;
}

#pragma mark - FSNativeAdsManagerDelegate
- (void)fs_nativeAdsManagerDidFail:(FSNativeAdsManager * _Nonnull)adsManager error:(NSError * _Nullable)error {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
}

- (void)fs_nativeAdsManagerSuccessToLoad:(FSNativeAdsManager * _Nonnull)adsManager nativeAds:(NSArray<FSNativeAd *> * _Nonnull)nativeAds {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
    if (nativeAds.count <= 0) {
        return;
    }
    self.nativeAd = nativeAds.firstObject;
    self.showButton.enabled = YES;
    
    NSLog(@"%d", self.nativeAd.material.isVideo);
    
    // 视频 or 图片
    self.isVideoSegment.selectedSegmentIndex = self.nativeAd.material.isVideo ? 0 : 1;
    
    // title & desc
    self.extraInfoLabel.text = [NSString stringWithFormat:@"[title]:%@ \n[desc]:%@", self.nativeAd.material.title, self.nativeAd.material.desc];
    
    // 视频素材
    self.videoWidthLabel.text = [NSString stringWithFormat:@"width:%.2lf", self.nativeAd.material.videoWidth];
    self.videoHeightLabel.text = [NSString stringWithFormat:@"height:%.2lf", self.nativeAd.material.videoHeight];
    self.videoSrcLabel.text = @"不对外提供";
    
    // 图片素材
    self.imageWidthLabel.text = [NSString stringWithFormat:@"width:%.2lf", self.nativeAd.material.images.firstObject.width];
    self.imageHeightLabel.text = [NSString stringWithFormat:@"height:%.2lf", self.nativeAd.material.images.firstObject.height];
    self.imageSrcLabel.text = [NSString stringWithFormat:@"%@", self.nativeAd.material.images.firstObject.url];
    
    // dsp
    self.dspInfoLabel.text = [NSString stringWithFormat:@"[dspID]:%@ \n[dspName]:%@", self.nativeAd.dspID, self.nativeAd.dspName];
    
    // app 信息
    FSApp *app = self.nativeAd.material.app;
    self.appInfoLabel.text = [NSString stringWithFormat:@"[app.name]: %@ \
                                                        \n[app.pkgName]: %@ \
                                                        \n[app.icon]: %@ \
                                                        \n[app.ID]: %@ \
                                                        \n[app.buttonText]: %@ \
                                                        \n[app.size]: %u",
                              app.name,
                              app.pkgName,
                              app.icon,
                              app.ID,
                              app.buttonText,
                              app.size];
    NSLog(@"%@", self.nativeAd.material.desc);
}

#pragma mark - FSNativeAdDelegate
- (void)fs_nativeAdDidBecomeVisibleWithNativeAd:(FSNativeAd *)nativeAd {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
    self.loadButton.enabled = YES;
}

- (void)fs_nativeAdDidClickWithNativeAd:(FSNativeAd *)nativeAd containerView:(UIView *)containerView {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
}

- (void)fs_nativeAdDidCloseOtherControllerWithNativeAd:(FSNativeAd *)nativeAd interactionType:(enum FSAdInteractionType)interactionType {
    NSLog(@"nativeAdDemo:%s intractionType:%ld", __FUNCTION__, interactionType);
}

#pragma mark - FSVideoAdViewDelegate
- (void)fs_videoAdViewReadyToPlay:(FSVideoAdView *)videoAdView {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
}

- (void)fs_videoAdViewDidPlayFinish:(FSVideoAdView *)videoAdView {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
}

- (void)fs_videoAdView:(FSVideoAdView *)videoAdView playStateDidChanged:(enum FSPlayerPlayState)playState {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
}

- (void)fs_videoAdView:(FSVideoAdView *)videoAdView didLoadFailedWithError:(NSError *)error {
    NSLog(@"nativeAdDemo:%s", __FUNCTION__);
}

@end
