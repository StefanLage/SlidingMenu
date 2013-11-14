//
//  SlidingMenuController.h
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

#import <UIKit/UIKit.h>

@interface SlidingMenuController : UIViewController{
    // Var to know the size of the slider when it's open -> by default == 20
    float portionOpenHorizontal;
    // Var to know if the slider will move vertically or not -> by default it does not move
    float portionOpenVertical;
    // Middle of the frame
    // Will be able to know if we need to open/close the slider
    float midPositionX;
    float maxPositionX;
    float maxPositionY;
    BOOL isOpen;
    // Bool to lock the slider
    BOOL isLocked;
    // Bool to allow user to slide manually
    BOOL isAllowManually;
}

// The front view controller
@property (retain, nonatomic) UIViewController *mainViewController;
// The back view controller
@property (retain, nonatomic) UIViewController *backViewController;

// Specific construtor
- (id)initWithView:(UIViewController*) mainView backView:(UIViewController*)backView;
// Function to set the portion that will be visible
- (void)set_horizontal_opening:(float)value;
// Let client choose if the flap can move or not ordinate
- (void)set_vertical_opening:(float)value;
// Open the slider
- (void)openSlider;
// Close the slider
- (void)closeSlider;
// Lock / Unlock slider
- (void)isLocked:(BOOL)value;
// Allow/block user to slide manually
- (void)isAllowManually:(BOOL)value;

@end