

// Extends the UIImage class to support resizing/cropping
@interface UIImage (Resize)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
