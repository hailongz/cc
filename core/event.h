//
//  event.h
//  kk
//
//  Created by zhanghailong on 2018/10/26.
//  Copyright © 2018年 kkmofang.cn. All rights reserved.
//

#ifndef kk_event_h
#define kk_event_h

#include <kk/kk.h>
#include <kk/jit.h>

namespace kk {
    
    class Event : public Object {
    public:
        virtual Object * data();
        virtual void setData(Object * data);
        KK_CLASS(Event,Object,"Event")
        static void Openlib();
    protected:
        Strong<Object> _data;
    };
    
    class EventEmitter : public Object {
    public:
        virtual void on(kk::CString name,kk::TFunction<void,Event *> * func);
        virtual void on(kk::CString name,JSObject * func);
        virtual void off(kk::CString name,kk::TFunction<void,Event *> * func);
        virtual void off(kk::CString name,JSObject * func);
        virtual void off(kk::CString name);
        virtual void off();
        virtual kk::Boolean has(kk::CString name);
        virtual void emit(kk::CString name,Event * event);
        
        KK_CLASS(EventEmitter,Object,"EventEmitter")
        
        static void Openlib();
    protected:
        virtual void on(kk::CString name,Object * func);
        virtual void off(kk::CString name,Object * func);
        std::map<String,std::list<Strong<Object>>> _events;
        std::map<String,std::list<Strong<Object>>> _prefixs;
    };
    
}

#endif /* event_h */
