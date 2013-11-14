//
//  SlidingMenuController.m
//  SlidingMenu
//
//  Created by Stefan Lage on 13/11/13.
//  Copyright (c) 2013 Stefan Lage. All rights reserved.
//
//  License Agreement for Source Code provided by Stefan Lage

//  This software is supplied to you by Stefan Lage in consideration of your agreement to the following
//  terms, and your use, installation, modification or redistribution of this software constitutes acceptance
//  of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute
//  this software.
//
//  In consideration of your agreement to abide by the following terms, and subject to these terms,
//  Stefan Lage grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software,
//  with or without modifications, in source and/or binary forms; provided that if you redistribute the software in
//  its entirety and without modifications, you must retain this notice and the following text and disclaimers in
//  all such redistributions of the software, and that in all cases attribution of Stefan Lage as the original
//  author of the source code shall be included in all such resulting software products or distributions. Neither
//  the name, trademarks, service marks or logos of Stefan Lage may be used to endorse or promote products
//  derived from the software without specific prior written permission from Stefan Lage. Except as expressly
//  stated in this notice, no other rights or licenses, express or implied, are granted by Stefan Lage herein,
//  including but not limited to any patent rights that may be infringed by your derivative works or by other works
//  in which the software may be incorporated.
//
//  The software is provided by Stefan Lage on an "AS IS" basis. STEFAN LAGE MAKES NO WARRANTIES, EXPRESS OR
//  IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
//
//  IN NO EVENT SHALL STEFAN LAGE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING,
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED
//  AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE,
//  EVEN IF STEFAN LAGE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "SlidingMenuController.h"

#pragma  Constantes

#define INIT_POSITION_X             0
#define INIT_POSITION_Y             0


@interface SlidingMenuController ()

@end

@implementation SlidingMenuController

// Own constructor
- (id)initWithView:(UIViewController*) mainView backView:(UIViewController*)backView{
    self = [super init];
    if(self){
        // Set mainview
        _mainViewController = mainView;
        // set backgroundview
        _backViewController = backView;
        // Set middle of the main frame
        midPositionX = mainView.view.frame.size.width/2;
        // By default allow user to slide manually
        [self isAllowManually:YES];
        // Add main and back views
        [self.view addSubview:_mainViewController.view];
        [self.view addSubview:_backViewController.view];
        // Bring main view in front
        [self.view bringSubviewToFront:_mainViewController.view];
    }
    return self;
}

#pragma Publics functions

// Public setter of front view visible
- (void)set_horizontal_opening:(float)value{
    portionOpenHorizontal = value;
    // In the mean time we calculate the postion of the flap in abscisse
    maxPositionX = self.mainViewController.view.frame.size.width - portionOpenHorizontal;
}

// Public setter to set Vertical movement
- (void)set_vertical_opening:(float)value{
    maxPositionY = value;
    portionOpenVertical = maxPositionY / maxPositionX;
}

// Open the slider
- (void)openSlider{
    // If slider is not locked we can move it
    if(!isLocked)
        [self openWithAnimation];
}
// Close the slider
- (void)closeSlider{
    // If slider is not locked we can move it
    if(!isLocked)
        [self closeWithAnimation];
}

// Lock / Unlock slider
- (void)isLocked:(BOOL)value{
    isLocked = value;
}

// Allow/block user to slide manually
- (void)isAllowManually:(BOOL)value{
    isAllowManually = value;
}

#pragma Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // If slider is not locked we can move it
    if(!isLocked){
        // get the touch
        UITouch *touch = [touches anyObject];
        // Close it if there is a tap on backview or if it's already open
        if([touch view] == self.backViewController.view || isOpen)
            [self closeWithAnimation];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // If slider is not locked we can move it
    if(!isLocked && isAllowManually){
        // get the touch
        UITouch *touch = [touches anyObject];
        // Do we need to move the mainView
        if ([touch view] == self.mainViewController.view)
            [self openSmoothly:touch];
        else
            isOpen = false;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // If slider is not locked we can move it
    if(!isLocked && isAllowManually){
        // get the touch
        UITouch *touch = [touches anyObject];
        if ([touch view] == self.mainViewController.view)
            [self openWithAnimation];
        else
            // Be sure to close the slider
            [self closeWithAnimation];
    }
}

#pragma Open

// Function to open smoothly
- (void)openSmoothly:(UITouch *)touch{
    // Get current location of the touch
    CGPoint location = [touch locationInView:self.mainViewController.view];
    // Get last position of the touch
    CGPoint previousLocation = [touch previousLocationInView:self.mainViewController.view];
    // calculate translation position in abscissa only
    CGFloat translatedPoint = location.x - previousLocation.x;
    // Calculate if we need to open or not the flap
    isOpen = self.mainViewController.view.frame.origin.x > midPositionX;
    // be sure we are not moving forward
    if((self.mainViewController.view.frame.origin.x + translatedPoint) < 0)
        return;
    // Does slider in X is allow to move ?
    if(self.mainViewController.view.frame.origin.x <= maxPositionX && self.mainViewController.view.frame.origin.y <= maxPositionY)
        self.mainViewController.view.center = CGPointMake(self.mainViewController.view.center.x + translatedPoint,
                                                          self.mainViewController.view.center.y + translatedPoint*(portionOpenVertical));
}

// Open directly the flap with an animation
- (void)openWithAnimation{
    // If slider is not locked we can move it
    if(!isLocked){
        [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             if(isOpen)
                                 // Open the flap at max position
                                 self.mainViewController.view.frame = CGRectMake(maxPositionX, maxPositionY, self.mainViewController.view.frame.size.width, _mainViewController.view.frame.size.height);
                             else
                                 // Close it
                                 self.mainViewController.view.frame = CGRectMake(INIT_POSITION_X, INIT_POSITION_Y, self.mainViewController.view.frame.size.width, self.mainViewController.view.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                             }
                         }];
    }
}

#pragma Close

// Close the flap with an animation
- (void)closeWithAnimation{
    // If slider is not locked we can move it
    if(!isLocked){
        [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             // Close it
                             self.mainViewController.view.frame = CGRectMake(INIT_POSITION_X, INIT_POSITION_Y, self.mainViewController.view.frame.size.width, self.mainViewController.view.frame.size.height);
                             // Inform the flap is close
                             isOpen = false;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                             }
                         }];
    }
}

@end
