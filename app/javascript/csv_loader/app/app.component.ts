import { Component } from '@angular/core';
import {template} from './app.template';
import { FormBuilder, Validators } from "@angular/forms";
import {ContactService} from '../../services/contact.service';
import {DataFileService} from '../../services/datafile.service';

@Component({
  selector: 'csv-loader',
  template: template
})
export class AppComponent {
  areColsDefined:boolean = false;
  fileLoaded:boolean = false;
  csv:any;
  lastFile:number;
  requestStatus:string = "hold";
  name:string = "-";
  size:number = 0;
  type:string = "-";
  cols:any = [
      "name", "dateofbirth",
      "phone", "address",
      "creditcard", "franchise",
      "email"
  ];  
  clines:any = [];
  definedCols:any = [undefined, undefined, 
    undefined, undefined, 
    undefined, undefined, undefined];
  constructor(public fb: FormBuilder, 
    private contactService: ContactService,
    private dataFileService: DataFileService) {
    
  }
  
  inCaseOfError() {
    this.requestStatus = "error";
    alert("Uups. Something has gone bad.");
  }
  
  changeCols(o) {
    this.definedCols[o['position']] = o['col'];
    let x = this.definedCols.filter(e => e === undefined);
    this.areColsDefined = (x === undefined || x.length <= 0);
    
  }
  startToRecord() {
    this.requestStatus = "running";
    this.dataFileService.create({
        columns: this.definedCols.join("|"),
        content: this.csv,
        format_content: 'plain/text'
      })
      .subscribe((res) => {
        this.startToSync(res["object"].id);
      }, (err) => {
        this.inCaseOfError();
      });   
  }
  
  startToSync(id) {
    this.lastFile = id;
    this.dataFileService.sync(id)
      .subscribe((res) => {
        this.clines = [];
        this.requestStatus = "done";
      }, (err) => {
        this.inCaseOfError();
      });
  }
  
  handleFileSelect(evt) {
    var files = evt.target.files; // FileList object
    if (files.length <= 0) {
      return;
    }
    let currentFile = files[0];
    this.name = currentFile.name;
    this.size = currentFile.size;
    this.type = currentFile.type;
    this.fileLoaded = (this.size > 0);
    
    
    var reader = new FileReader();

    reader.readAsText(currentFile);
    reader.onload = (event: any) => {
      this.csv = event.target.result; // Content of CSV file
      var lines = this.csv.split("\n");
      this.clines = [];
      for(let l of lines) {
        let cols = l.trim().split(",");
        this.clines.push({
          'cols': cols,
          'status': undefined
        });
      }
    }
  }
}
