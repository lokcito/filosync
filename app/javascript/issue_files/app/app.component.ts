import { Component, OnInit, Input } from '@angular/core';
import {template} from './app.template';
import {IssueFileService } from './../../services/issuefile.service';

@Component({
  selector: 'ry-issue-files',
  template: template
})
export class RyIssueFileComponent implements OnInit {
  list:any = [];
  meta:any = {};
  params:any = {};
  @Input() data_file:number;
  constructor(private issueFileService: IssueFileService) {}
  inCaseOfError() {

    alert("Uups. Something has gone bad.");
  }
  ngOnInit() {
    if (this.data_file){
      this.params['data_file_id'] = this.data_file;
    }
    this.load();
  }
  load() {
    this.issueFileService.filter(this.params)
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
