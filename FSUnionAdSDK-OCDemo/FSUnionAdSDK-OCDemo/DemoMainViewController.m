//
//  DemoMainViewController.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/18.
//

#import "DemoMainViewController.h"
#import "InterstitialAd/InterstitialAdDemoViewController.h"
#import "SplashAd/SplashAdDemoViewController.h"
#import "NativeAd/NativeAdDemoViewController.h"

@interface DemoMainViewController ()

@end

@implementation DemoMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.item) {
//        case 0:
//        {
//            SplashAdDemoViewController *vc = [[SplashAdDemoViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 1:
//        {
//            InterstitialAdDemoViewController *vc = [[InterstitialAdDemoViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 2:
//        {
//            NativeAdDemoViewController *vc = [[NativeAdDemoViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        default:
//            break;
//    }
//}

@end
