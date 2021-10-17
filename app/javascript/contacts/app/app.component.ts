import { Component, OnInit, Input } from '@angular/core';
import {template} from './app.template';
import {ContactService } from './../../services/contact.service';

@Component({
  selector: 'ry-contacts',
  template: template
})
export class RyContactComponent implements OnInit {
  list:any = [];
  meta:any = {};
  params:any = {};
  @Input() data_file:number;
  constructor(private contactService: ContactService) {}
  inCaseOfError() {
    alert("Uups. Something has gone bad.");
  }
  ngOnInit() {
    if (this.data_file){
      this.params['data_file_id'] = this.data_file;
    }    
    this.load();
  }
  next() {
    this.params["offset"] = this.meta["offset"];
    this.load();
  }
  back() {
    this.params["offset"] = this.meta["offset"] - this.meta["limit"]*2;
    this.load();
  }
  load() {
    this.contactService.filter(this.params)
      .subscribe((res) => {
        this.list = res["objects"];
        this.meta = res["meta"];
      }, (err) => {
        this.inCaseOfError();
      });    
  }
}
