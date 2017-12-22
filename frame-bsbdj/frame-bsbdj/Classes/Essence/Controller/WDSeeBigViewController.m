//
//  WDSeeBigViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/15.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDSeeBigViewController.h"
#import "WDTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Photos/Photos.h>



@interface WDSeeBigViewController () <UIScrollViewDelegate>

// 图片空间
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation WDSeeBigViewController

static NSString * WDAssetCollectionTitle = @"高仿->不得姐";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image == nil) return ;
        self.saveBtn.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    
    imageView.wd_width = scrollView.wd_width;
    imageView.wd_height = self.topic.height * imageView.wd_width / self.topic.width;
    imageView.wd_x = 0;
    
    if (imageView.wd_height >= scrollView.wd_height) {  // 图片高度超过屏幕高度
        imageView.wd_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.wd_height);
    } else {
        // 居中显示
        imageView.wd_centerY = scrollView.wd_height * 0.5;
    }
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale = self.topic.width / imageView.wd_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}

// 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
// 设置状态栏为白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
//    // 直接将图片写入到相册
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageToPhoto:didFinishSavingWithError:contextInfo:), nil);
    
    
//    PHAuthorizationStatusNotDetermined = 0, // 用户尚未作出选择
//    PHAuthorizationStatusRestricted,        // 因为家长控制，导致应用无法访问（跟用户的选择无关）
//    PHAuthorizationStatusDenied,            // 用户拒绝当前应用的访问（选择了“不允许”）
//    PHAuthorizationStatusAuthorized         // 用户允许当前应用访问相册（选择了“好”）
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted) {
        [SVProgressHUD showErrorWithStatus:@"因系统原因无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied) {
        // 提醒用户去：设置->隐私->照片->应用，打开访问开关
    } else if (status == PHAuthorizationStatusAuthorized) {
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) {
        // 请求授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage
{
    // 1. 保存图片A到“相机胶卷”中
    // 2. 创建“相簿”D
    // 3. 添加“相机胶卷”中的图片A到新建的“相簿”中
    
    // PHAsset的标识，利用这个标识可以找到对应的PHAsset对象（图片对象）
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    // 如果想对“相册”进行修改（增删改），那么修改代码必须放在[PHPhotoLibrary sharePhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1. 首先将图片保存到“相机胶卷”中
        // 创建图片的请求
        assetCollectionLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存图片失败！"];
            return ;
        }
        
        // 2. 获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection == nil) {
            [self showError:@"创建相簿失败"];
            return;
        }
        
        //
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3. 将保存到“相机胶卷”中对应的图片添加到“相簿”中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存图片失败！"];
            } else {
                [self showSuccess:@"保存图片成功！"];
            }
        }];
        
    }];
}


// 获得相簿
- (PHAssetCollection *)createdAssetCollection
{
    // 从已存在的相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection* assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:WDAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    // 没有找到对应的相簿，创建新的相簿
    NSError *error = nil;
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:WDAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) {
        return nil;
    }
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:assetCollectionLocalIdentifier options:nil].lastObject;
}


- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}


- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

- (void)imageToPhoto:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"写入成功"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }
}

#pragma mark - UIScrollViewDelegate 方法
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
