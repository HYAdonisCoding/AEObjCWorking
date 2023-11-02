//
//  UIImage+AEBlackAndWhite.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/1/3.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "UIImage+AEBlackAndWhite.h"

@implementation UIImage (AEBlackAndWhite)
+ (UIImage *)changeColoursTogray:(UIImage *)anImage type:(ImageChangeType)type {
    if (anImage == nil) {
        return anImage;
    }
    
    CGImageRef imageRef = anImage.CGImage;
    
    size_t width = CGImageGetWidth(imageRef);
    
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitMapInfo = CGImageGetBitmapInfo(imageRef);
    
    bool shouldInterPolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8  *)CFDataGetBytePtr(data);
    
    NSInteger x,y;
    
    for (y = 0; y < height; y++) {
        
        for (x = 0; x < width; x++) {

            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            UInt8 red,green,blue;
            red     = *(tmp + 0);
            green = *(tmp + 1);
            blue   = *(tmp + 2);

            
            UInt8 brightness;
            
            switch (type) {
                case ImageChangeTypeBW:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = brightness;
                    
                    *(tmp + 1) = brightness;
                    
                    *(tmp + 1) = brightness;
                    
                    break;
                    
                case ImageChangeTypePink:
                    
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = red;
                    
                    *(tmp + 1) = green * 0.7;
                    
                    *(tmp + 1) = blue *0.4;
                    
                    break;
                    
                case ImageChangeTypeBlue:
                    
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = 255 - red;
                    
                    *(tmp + 1) = 255 - green;
                    
                    *(tmp + 1) = 255 - blue;
                    
                    break;
                default:
                    
                    *(tmp + 0) = red;
                    
                    *(tmp + 1) = green;
                    
                    *(tmp + 2) = blue;
                    
                    break;
            }

        }
        
    }
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCGImage = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, bitMapInfo, effectedDataProvider, NULL, shouldInterPolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc]initWithCGImage:effectedCGImage];
    
    CGImageRelease(effectedCGImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
}


+ (void)ae_imageSwizzldMethedWith:(BOOL)changeGray {
    
    if (changeGray == false) {
        return;
    }
    //交换方法
    Class cls = object_getClass(self);
    Method originMethod = class_getClassMethod(cls, @selector(imageNamed:));
    Method swizzledMethod = class_getClassMethod(cls, @selector(ad_imageNamed:));
    
    [self swizzleMethodWithOriginSel:@selector(imageNamed:) oriMethod:originMethod swizzledSel:@selector(ad_imageNamed:) swizzledMethod:swizzledMethod class:cls];
    
    Method originMethod1 = class_getClassMethod(cls, @selector(imageWithData:));
    Method swizzledMethod1 = class_getClassMethod(cls, @selector(ad_imageWithData:));
    [self swizzleMethodWithOriginSel:@selector(imageWithData:) oriMethod:originMethod1 swizzledSel:@selector(ad_imageWithData:) swizzledMethod:swizzledMethod1 class:cls];
    
}

+ (void)swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                       swizzledSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls {
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
}

+ (UIImage *)ad_imageWithData:(NSData *)data {
    UIImage *image = [self ad_imageWithData:data];
    return [image grayImage];
}

+ (UIImage *)ad_imageNamed:(NSString *)name {
    UIImage *image = [self ad_imageNamed:name];
    return [image grayImage];
}

// 转化灰度
- (UIImage *)grayImage {
    const int RED =1;
    const int GREEN =2;
    const int BLUE =3;

    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, self.size.width* self.scale, self.size.height* self.scale);

    int width = imageRect.size.width;
    int height = imageRect.size.height;

    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));

    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);

    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [self CGImage]);

    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];

            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];

            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }

    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);

    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);

    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];

    // we're done with image now too
    CGImageRelease(imageRef);

    return resultUIImage;
}

@end


@implementation UIImageView (AEGrayImage)
- (void)sd_setImageWithURL:(nullable NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil];
    
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options context:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options context:(SDWebImageContext *)context {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options context:context progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image.grayImage;
    }];
}

@end
