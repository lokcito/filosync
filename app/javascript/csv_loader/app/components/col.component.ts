import {Component, 
    Input, 
    Output, 
    EventEmitter, 
    OnChanges,
    DoCheck 
} from '@angular/core';
import {FormBuilder} from '@angular/forms';
import {template} from './col.template';

@Component({
    'selector': 'col-selector',
    'template': template
})

export class ColSelectorComponent implements DoCheck {
    _cols:any = [];
    @Input() cols:any;
    @Input() position:number;
    @Input() defined:any;
    @Output() onSelected = new EventEmitter<any>();
    
    constructor(private fb: FormBuilder) {}
    colForm = this.fb.group({
        col: ['']
    });
    public ngDoCheck(): void {
        let u = this.defined
            .filter((e, i) => (e !== undefined && i !== this.position));
        
        if ( !u && u.length <= 0 ) {
            return;
        }
        
        let o = this.cols.filter(e => !u.includes(e));
        if ( o && o.length !== this._cols ) {
            this._cols = o;
        }
    }
    remove() {
        this.colForm.patchValue({col: undefined});
        this.change();
    }
    change() {
        this.onSelected.emit({
            'position': this.position,
            ...this.colForm.value
        });
    }
}