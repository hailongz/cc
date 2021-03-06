//
//  UITextView+KKViewProtocol.m
//  KK
//
//  Created by zhanghailong on 2018/11/8.
//  Copyright © 2018 kkmofang.cn. All rights reserved.
//

#import "UITextView+KKViewProtocol.h"

#import "KKObject.h"
#include <ui/ui.h>
#include <ui/view.h>
#include <objc/runtime.h>

@interface UITextViewKKViewProtocol : NSObject<UITextViewDelegate>

@property(nonatomic,assign) kk::ui::View * view;

@end

@implementation UITextViewKKViewProtocol

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
    
    if(_view) {
        NSString * text = [textView.text stringByReplacingCharactersInRange:range withString:string];
        kk::Strong<kk::Event> e = new kk::Event();
        kk::Strong<kk::TObject<kk::String, kk::String>> data = new kk::TObject<kk::String, kk::String>({{"value",[text UTF8String]}});
        e->setData(data);
        _view->emit("change", e);
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if(_view) {
        kk::Strong<kk::Event> e = new kk::Event();
        _view->emit("focus", e);
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if(_view) {
        kk::Strong<kk::Event> e = new kk::Event();
        _view->emit("blur", e);
    }
    
    return YES;
}


@end

@implementation UITextView (KKViewProtocol)

-(void) KKViewObtain:(void *) view {
    [super KKViewObtain:view];
    UITextViewKKViewProtocol * object = [[UITextViewKKViewProtocol alloc] init];
    object.view = (kk::ui::View *) view;
    self.delegate = object;
    objc_setAssociatedObject(self, "__UITextViewKKViewProtocol", object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) KKViewRecycle:(void *) view {
    [super KKViewRecycle:view];
    UITextViewKKViewProtocol * object = objc_getAssociatedObject(self, "__UITextViewKKViewProtocol");
    if(object) {
        self.delegate = nil;
        objc_setAssociatedObject(self, "__UITextViewKKViewProtocol", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(void) KKViewSetAttribute:(const char *) key value:(const char *) value {
    
    [super KKViewSetAttribute:key value:value];
    
    if(key == nullptr) {
        return ;
    }
    
    if(strcmp(key, "value") == 0) {
        self.text = value? [NSString stringWithCString:value encoding:NSUTF8StringEncoding] : nil;
    } else if(strcmp(key, "type") == 0) {
        if(value == nullptr || strcmp(value, "text") == 0) {
            self.keyboardType = UIKeyboardTypeDefault;
        } else if(strcmp(value, "number") == 0) {
            self.keyboardType = UIKeyboardTypeNumberPad;
        } else if(strcmp(value, "digit") == 0) {
            self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        } else {
            self.keyboardType = UIKeyboardTypeDefault;
        }
    } else if(strcmp(key, "disabled") == 0) {
        self.editable = !(value != nullptr && strcmp(value, "true") == 0);
    } else if(strcmp(key, "focus") == 0) {
        if(value != nullptr && strcmp(value, "true") == 0) {
            [self becomeFirstResponder];
        }
    } else if(strcmp(key, "confirm-type") == 0) {
        if(value == nullptr || strcmp(value, "done") == 0) {
            self.returnKeyType = UIReturnKeyDone;
        } else if(strcmp(value, "send") == 0) {
            self.returnKeyType = UIReturnKeySend;
        } else if(strcmp(value, "search") == 0) {
            self.returnKeyType = UIReturnKeySearch;
        } else if(strcmp(value, "next") == 0) {
            self.returnKeyType = UIReturnKeyNext;
        } else if(strcmp(value, "go") == 0) {
            self.returnKeyType = UIReturnKeyGo;
        } else {
            self.returnKeyType = UIReturnKeyDone;
        }
    } else if(strcmp(key, "color") == 0) {
        kk::ui::Color v(value);
        self.backgroundColor = [UIColor colorWithRed:v.r green:v.g blue:v.b alpha:v.a];
    } else if(strcmp(key, "font") == 0) {
        
        kk::ui::Font v(value);
        
        UIFont * font = nil;
        
        if(v.family != "") {
            NSString * name = [[UIFont fontNamesForFamilyName:[NSString stringWithCString:v.family.c_str() encoding:NSUTF8StringEncoding]] firstObject];
            if(name != nil) {
                font = [UIFont fontWithName:name size:v.size];
            }
        }
        
        if(font == nil && v.weight == kk::ui::FontWeightBold) {
            font = [UIFont boldSystemFontOfSize:v.size];
        }
        
        if(font == nil && v.style == kk::ui::FontStyleItalic) {
            font = [UIFont italicSystemFontOfSize:v.size];
        }
        
        if(font == nil ) {
            font = [UIFont systemFontOfSize:v.size];
        }
        
        self.font = font;
        
    } else {
        kk::ui::TextAlign v = kk::ui::TextAlignFromString(value);
        
        switch (v) {
            case kk::ui::TextAlignEnd:
            case kk::ui::TextAlignRight:
                self.textAlignment = NSTextAlignmentRight;
                break;
            case kk::ui::TextAlignCenter:
                self.textAlignment = NSTextAlignmentCenter;
                break;
            default:
                self.textAlignment = NSTextAlignmentLeft;
                break;
        }
        
    }
    
}

@end



