//
//  FeedBrandAdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/19.
//

#import "FeedBrandAdDemoViewController.h"
#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

@interface FeedBrandAdDemoViewController ()<FSNativeExpressFeedsAdDelegate>
{
    NSUInteger _adIndex;
    BOOL _loadSuccess;
}
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *indexTextField;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (nonatomic, strong) FSNativeExpressFeedsAd *feedsBrandAd;

@end

@implementation FeedBrandAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"FSNativeExpressFeedsAd";
}

#pragma mark - private
- (void)_loadAdWithSlotID:(NSString *)slotID {
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:slotID type:FSAdTypeNativeExpress];
    FSNativeExpressFeedsAd *ad = [[FSNativeExpressFeedsAd alloc] initWithSlot:slot];
    ad.expressType = FSNativeExpressTypeBrand;
    ad.delegate = self;
    ad.rootViewController = self;
    [ad loadAdData];
    self.feedsBrandAd = ad;
}

#pragma mark - IBAction
- (IBAction)refreshButtonClick:(UIButton *)sender {
    if (!self.slotIDTextField.text.length) {
        return;
    }
    self.refreshButton.enabled = NO;
    
    _adIndex = self.indexTextField.text.integerValue;
    _adIndex = MIN(MAX(0, _adIndex), 50);
    
    _loadSuccess = NO;
    [self _loadAdWithSlotID:self.slotIDTextField.text];
}

#pragma mark - FSNativeExpressFeedsAdDelegate
- (void)fs_expressFeedAdLoadSuccess:(FSNativeExpressFeedsAd *)ad {
    self.refreshButton.enabled = YES;
    
    _loadSuccess = YES;
    
    [self.feedsBrandAd showInView:self.view];
}

- (void)fs_expressFeedAdLoadFailed:(FSNativeExpressFeedsAd *)ad withError:(NSError *)error {
    self.refreshButton.enabled = YES;
}

- (void)fs_expressFeedAdShowSuccess:(FSNativeExpressFeedsAd *)ad {
    
}

- (void)fs_expressFeedAdShowFailed:(FSNativeExpressFeedsAd *)ad withError:(NSError *)error {
    
}

- (void)fs_expressFeedAdDidClosed:(FSNativeExpressFeedsAd *)ad {
    self.feedsBrandAd = nil;
}

- (void)fs_expressFeedAdDidClicked:(FSNativeExpressFeedsAd *)ad {
    
}

@end
