

import { Element } from "./Element"

interface ElemnetClassMap {
    [keys: string]: any
}

interface ElemnetMap {
    [keys: number]: Element
}

export class Document {

    private _autoId:number = 0;
    private _elementClass:ElemnetClassMap = {};
    private _elements:ElemnetMap = {};
    private _documentElement:Element = new Element(this,"document",0);

    createElement(name:string):Element {
        let id = ++ this._autoId;
        let fn = this._elementClass[name];
        var v:Element;
        if (fn === undefined) {
            v = new Element(this,name,id);
        } else {
            v = new fn(this,name,id);
        }
        this._elements[id] = v;
        return v;
    }

    element(id:number):Element | undefined {
        return this._elements[id];
    }

    removeElement(id:number):void {
        delete this._elementClass[id];
    }

    addElementClass(name:string,elementClass:any):void {
        this._elementClass[name] = elementClass;
    }

    public get documentElement():Element{
        return this._documentElement;
    }

}
