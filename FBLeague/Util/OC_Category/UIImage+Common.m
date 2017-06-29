//
//  UIImage+Common.m
//  HotMate
//
//  Created by JinXin on 15/1/4.
//  Copyright (c) 2015年 iwoapp. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// --------------------------------------------------

// Resize an image

// --------------------------------------------------

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height {
    
    CGFloat destW = width;
    
    CGFloat destH = height;
    
    CGFloat sourceW = width;
    
    CGFloat sourceH = height;
    
    
    
    CGImageRef imageRef = self.CGImage;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                
                                                destW,
                                                
                                                destH,
                                                
                                                CGImageGetBitsPerComponent(imageRef),
                                                
                                                4*destW, 
                                                
                                                CGImageGetColorSpace(imageRef),
                                                
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    
    CGImageRelease(ref);
    
    
    
    return resultImage;
    
}

@end
