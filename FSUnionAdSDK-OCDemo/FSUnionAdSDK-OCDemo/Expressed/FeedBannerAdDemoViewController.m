//
//  FeedBannerAdDemoViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/19.
//

#import "FeedBannerAdDemoViewController.h"
#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

@interface FeedBannerAdDemoViewController ()
<
FSNativeExpressFeedsAdDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    NSUInteger _adIndex;
    BOOL _loadSuccess;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *indexTextField;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (nonatomic, strong) UITableViewCell *adCell;

@property (nonatomic, strong) FSNativeExpressFeedsAd *feedBannerAd;

@end

@implementation FeedBannerAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"FSNativeExpressFeedsAd";
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
//    [self _loadAdWithSlotID:self.slotIDTextField.text];
}

#pragma mark - private
- (void)_loadAdWithSlotID:(NSString *)slotID {
    FSAdSlot *slot = [[FSAdSlot alloc] initWithSlotID:slotID type:FSAdTypeNativeExpress];
    FSNativeExpressFeedsAd *ad = [[FSNativeExpressFeedsAd alloc] initWithSlot:slot];
    ad.expressType = FSNativeExpressTypeBanner;
    ad.delegate = self;
    ad.rootViewController = self;
    [ad loadAdData];
    self.feedBannerAd = ad;
}

- (UITableViewCell *)adCell {
    if (!_adCell) {
        _adCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 108)];
        _adCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _adCell.contentView.backgroundColor = UIColor.lightGrayColor;
    }
    return _adCell;
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
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
    self.refreshButton.enabled = YES;
    
    _loadSuccess = YES;
    [self.tableView reloadData];
}

- (void)fs_expressFeedAdLoadFailed:(FSNativeExpressFeedsAd *)ad withError:(NSError *)error {
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
    self.refreshButton.enabled = YES;
}

- (void)fs_expressFeedAdShowSuccess:(FSNativeExpressFeedsAd *)ad {
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
}

- (void)fs_expressFeedAdShowFailed:(FSNativeExpressFeedsAd *)ad withError:(NSError *)error {
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
}

- (void)fs_expressFeedAdDidClosed:(FSNativeExpressFeedsAd *)ad {
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
    self.feedBannerAd = nil;
}

- (void)fs_expressFeedAdDidClicked:(FSNativeExpressFeedsAd *)ad {
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
}

- (void)fs_expressFeedAdDidCloseOtherController:(FSNativeExpressFeedsAd *)ad interactionType:(enum FSAdInteractionType)interactionType {
    NSLog(@"feedBannerAdDemo:%s", __FUNCTION__);
}

#pragma mark - UITabelViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _adIndex) {
        if (_loadSuccess) {
            [self.feedBannerAd showInView:self.adCell.contentView];
            _loadSuccess = NO;
        }
        return self.adCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_adIndex == indexPath.row) {
        return 329.0;
    } else {
        return 44.0;
    }
}

@end
