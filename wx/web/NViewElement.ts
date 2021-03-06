import { ViewElement } from './ViewElement';
import { Element as KKElement } from './Element';
import { postMessage } from './IPC';
import { once } from './once';

var _autoId = 0;

export class NViewElement extends ViewElement {

    protected createView(): Element {
        var v = document.createElement("wx-" + this._name);
        postMessage({
            view: 'create',
            id: this._id,
            name: this._name
        });
        return v;
    }

    protected _displaying: boolean = false;

    public display(): void {

        var p: HTMLElement | undefined = this._view as HTMLElement;
        var x: number = 0;
        var y: number = 0;

        while (p !== undefined && p != document.body) {

            x += p.offsetLeft;
            y += p.offsetTop;

            p = p.offsetParent as (HTMLElement | undefined);
        }

        postMessage({
            view: 'setFrame',
            id: this._id,
            x: x,
            y: y,
            width: this._view.clientWidth,
            height: this._view.clientHeight
        });

        this._displaying = false;
    }

    public setNeedsDisplay(): void {
        if (this._displaying) {
            return;
        }
        this._displaying = true;
        var v = this;
        once(function () {
            v.display();
        });
    }

    public set(key: string, value: string | undefined) {
        super.set(key, value);
        postMessage({
            view: 'set',
            id: this._id,
            name: key,
            value: value
        });
        this.setNeedsDisplay();
    }

    protected onDidAddToParent(element: KKElement): void {
        super.onDidAddToParent(element);

        var pid: number | undefined = undefined;

        if (element instanceof NViewElement) {
            pid = element._id;
        }

        postMessage({
            view: 'add',
            id: this._id,
            pid: pid
        });

        this.setNeedsDisplay();
    }

    protected onWillRemoveFromParent(element: KKElement): void {
        super.onWillRemoveFromParent(element);

        postMessage({
            view: 'remove',
            id: this._id
        });
    }

    public recycle(): void {

        postMessage({
            view: 'remove',
            id: this._id
        });

        super.recycle();

    }


}
