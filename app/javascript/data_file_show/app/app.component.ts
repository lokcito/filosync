import { Component, OnInit, ElementRef} from '@angular/core';
import {template} from './app.template';
import {DataFileService} from '../../services/datafile.service';

@Component({
  selector: 'ry-data-file-show',
  template: template
})
export class AppComponent implements OnInit {
  id:number;
  constructor(private elementRef: ElementRef) {
     this.id = parseInt(this.elementRef.nativeElement.getAttribute('id'))
  }
  ngOnInit() {
  }
}
