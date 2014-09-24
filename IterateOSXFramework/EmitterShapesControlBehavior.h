//
//  EmitterHeightConstantControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterConstantControlBehavior.h"

@interface EmitterShapesControlBehavior : EmitterConstantControlBehavior

//X, Y, Z
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *specialPointHeightConstraints;

//X, Y, Z, width
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *specialLineHeightConstraints;

//x, y, z, width, height
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *specialRectangleHeightConstraints;

//x, y, z, depth, width, height
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *specialCuboidHeightConstraints;

//x, y, z, width
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *specialCircleHeightConstraints;

//x, y, z, width
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *specialSphereHeightConstraints;


@end
