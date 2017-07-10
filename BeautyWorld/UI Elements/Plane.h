//
//  Plane.h
//  BeautyWorld
//
//  Created by CGLab on 2017/7/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#ifndef Plane_h
#define Plane_h
//
//  Plane.h
//  arkit-by-example
//
//  Created by md on 6/9/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface Plane : SCNNode
- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor isHidden:(BOOL)hidden withMaterial:(SCNMaterial *)material;
- (void)update:(ARPlaneAnchor *)anchor;
- (void)setTextureScale;
- (void)hide;
- (void)changeMaterial;
- (void)remove;
+ (SCNMaterial *)currentMaterial;
@property (nonatomic,retain) ARPlaneAnchor *anchor;
@property (nonatomic, retain) SCNBox *planeGeometry;
@end

#endif /* Plane_h */
