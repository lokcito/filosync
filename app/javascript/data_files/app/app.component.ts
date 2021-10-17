import { Component, OnInit } from '@angular/core';
import {template} from './app.template';
import {DataFileService} from '../../services/datafile.service';

@Component({
  selector: 'ry-data-files',
  template: template
})
export class AppComponent implements OnInit {
  list:any = [];
  meta:any = {};
  params:any = {};
  constructor(private dataFileService: DataFileService) {}
  ngOnInit() {
    this.load();
  }
  inCaseOfError() {
    alert("Uups. Something has gone bad.");
  }
  load() {
    this.dataFileService.filter(this.params)
      .subscribe((res) => {
        this.list = res["objects"];
        this.meta = res["meta"];
      }, (err) => {
        this.inCaseOfError();
      });    
  }
  next() {
    this.params["offset"] = this.meta["offset"];
    this.load();
  }
  back() {
    this.params["offset"] = this.meta["offset"] - this.meta["limit"]*2;
    this.load();
  }
}
