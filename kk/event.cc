//
//  event.cpp
//  kk
//
//  Created by zhanghailong on 2018/10/26.
//  Copyright © 2018年 kkmofang.cn. All rights reserved.
//

#include <kk/event.h>

namespace kk {
    
    
    void EventEmitter::on(kk::CString name,Object * func) {
        String n = name;
        std::map<String,std::list<Strong<Object>>>::iterator i;
        
        if(n.endsWith("*")) {
            n = n.substr(0,n.length()-1);
            i = _prefixs.find(n);
            if(i == _prefixs.end()) {
                _prefixs[n] = {func};
            } else {
                i->second.push_back(func);
            }
        } else {
            i = _events.find(n);
            if(i == _events.end()) {
                _events[name] = {func};
            } else {
                i->second.push_back(func);
            }
        }
    }
    
    void EventEmitter::on(kk::CString name,kk::TFunction<void,Event *> * func) {
        on(name,(Object *) func);
    }
    
    void EventEmitter::on(kk::CString name,JSObject * func) {
        on(name,(Object *) func);
    }
    
    void EventEmitter::off(kk::CString name,Object * func) {
        
        if(name == nullptr) {
            _events.clear();
            _prefixs.clear();
            return;
        }
        
        String n = name;
        std::map<String,std::list<Strong<Object>>>::iterator i;
        
        if(n.endsWith("*")) {
            n = n.substr(0,n.length()-1);
            i = _prefixs.find(n);
            if(i != _prefixs.end()) {
                if(func == nullptr) {
                    _prefixs.erase(i);
                } else {
                    std::list<Strong<Object>> & vs = i->second;
                    std::list<Strong<Object>>::iterator n = vs.begin();
                    while(n != vs.end()) {
                        if((*n).get() == func) {
                            n = vs.erase(n);
                            continue;
                        }
                        n ++ ;
                    }
                }
            }
        } else {
            i = _events.find(n);
            if(i != _events.end()) {
                if(func == nullptr) {
                    _events.erase(i);
                } else {
                    std::list<Strong<Object>> & vs = i->second;
                    std::list<Strong<Object>>::iterator n = vs.begin();
                    while(n != vs.end()) {
                        if((*n).get() == func) {
                            n = vs.erase(n);
                            continue;
                        }
                        n ++ ;
                    }
                }
            }
        }
        
    }
    
    void EventEmitter::off(kk::CString name,kk::TFunction<void,Event *> * func) {
        off(name,(Object *) func);
    }
    
    void EventEmitter::off(kk::CString name,JSObject * func) {
        off(name,(Object *) func);
    }
    
    void EventEmitter::off(kk::CString name) {
        off(name,(Object *) nullptr);
    }
    
    void EventEmitter::off() {
        off((kk::CString) nullptr,(Object *) nullptr);
    }
    
    kk::Boolean EventEmitter::has(kk::CString name) {
        
        if( _events.find(name) != _events.end() ) {
            return true;
        }
        
        String n(name);
        std::map<String,std::list<Strong<Object>>>::iterator i = _prefixs.begin();
        while(i != _prefixs.end()) {
            if(n.startsWith(i->first)) {
                return true;
            }
            i ++;
        }
        return false;
    }
    
    void EventEmitter::emit(kk::CString name,Event * event) {
        
        std::list<Strong<Object>> vs;
        
        String n(name);
        
        std::map<String,std::list<Strong<Object>>>::iterator i = _events.find(n);
        
        if(i != _events.end()) {
            vs = i->second;
        }
        
        i = _prefixs.begin();
        while(i != _prefixs.end()) {
            if(n.startsWith(i->first)) {
                //todo
            }
            i ++;
        }
        
        std::list<Strong<Object>>::iterator k = vs.begin();
        
        while(k != vs.end()) {
            {
                JSObject * fn = dynamic_cast<JSObject *>((*k).get());
                
                if(fn != nullptr) {
                    
                    
                    
                    k ++ ;
                    continue;
                }
            }
            k ++;
        }
    }
    
    
}
