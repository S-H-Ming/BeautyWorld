//
//  PBRMaterial.h
//  BeautyWorld
//
//  Created by CGLab on 2017/7/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#ifndef PBRMaterial_h
#define PBRMaterial_h
#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface PBRMaterial : NSObject
+ (SCNMaterial *)materialNamed:(NSString *)name;
@end

#endif /* PBRMaterial_h */
