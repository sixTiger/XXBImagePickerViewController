# XXBImagePickerViewController
初始化跟系统自在的图片徐咱泽器一样好用直接push就行


里边注释很多，很方便初学者


只需要导入XXBImagePickerController.h

- (IBAction)openXXBImagePicker:(id)sender {
    XXBImagePickerController  *imagePickController = [[XXBImagePickerController alloc] init];
    [self presentViewController:imagePickController animated:YES completion:nil];
}

相关的返回结果在代理里边

#import <UIKit/UIKit.h>
@class XXBImagePickerController;

@protocol XXBImagePickerControllerDelegate <NSObject>

@optional
//取消
- (void)imagePickerControllerCancleselect:(XXBImagePickerController *)imagePickController;
// 确定
- (void)imagePickerController:(XXBImagePickerController *)imagePickController didselectPhotos:(NSArray *)selectPhotos;

@end

@interface XXBImagePickerController : UINavigationController


/**
 *  一行显示的照片个数
 *  默认是4个
 */
@property(nonatomic , assign)NSInteger photoInRow;
/**
 *  如果想在打开的时候原来选中的图片还是选中的话需要设置 selectPhotoALAssets
 *
 *  里边放的是 XXBPhotoAlasetModle 模型
 *
 *  原来选中的photo的ALAsset 默认为空
 */
@property(nonatomic , strong)NSMutableArray *selectPhotoALAssets;
/**
 *  用来处理选中和和取消的代理方法
 */
@property(nonatomic , weak)id<XXBImagePickerControllerDelegate> imagePickerDelegate;

@end
