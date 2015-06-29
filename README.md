# XXBImagePickerViewController
## 初始化跟系统自在的图片选择器一样好用直接push就行
 * 可以对选择的照片进行排序 <br>
 * 可以设置右上角的指示数字按钮<br>
 * 只需要导入XXBImagePickerController.h
``` c
- (void)openPhoto
{
    // 创建一个照片选择器
    XXBImagePickerController  *imagePickController = [[XXBImagePickerController alloc] init];
    // 设置做多可选的照片数
    imagePickController.photoCount = 3;
    // 是都展示左上角的数字标签
    imagePickController.showPage = YES;
    //  是否默认打开全部相册
    imagePickController.showAllPhoto = YES;
    //  设置代理
    imagePickController.imagePickerDelegate = self;
    //  返回照片的排序方式
    imagePickController.photoSortType = XXBPhotoSortTypeSystemOrder;
    [self presentViewController:imagePickController animated:YES completion:^{
        
    }];
}
```
## 相关的返回结果在代理里边
   代理方法
``` c
//取消
- (void)imagePickerControllerCancleselect:(XXBImagePickerController *)imagePickController;
// 确定
- (void)imagePickerController:(XXBImagePickerController *)imagePickController didselectPhotos:(NSArray *)selectPhotos;
```
## *相关属性
``` c
//  一行显示的照片个数
//  默认是4个
@property(nonatomic , assign)NSInteger photoInRow;
```
//  如果想在打开的时候原来选中的图片还是选中的话需要设置 selectPhotoALAssets  里边放的是 XXBPhotoAlasetModle 模型 <br>
原来选中的photo的ALAsset 默认为空<br>
``` c
@property(nonatomic , strong)NSMutableArray *selectPhotoALAssets;
```
#ipaid的效果图
![image](./image/1.png)<br>
![image](./image/2.png)
![image](./image/3.png)
#iphone的效果图
![image](./image/4.png)<br>
![image](./image/5.png)
![image](./image/6.png)

