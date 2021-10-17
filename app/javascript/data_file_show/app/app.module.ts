import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { AppComponent } from './app.component';
import {RyContactComponent} from '../../contacts/app/app.component';
import {RyIssueFileComponent} from '../../issue_files/app/app.component';

@NgModule({
  declarations: [
    AppComponent,
    RyContactComponent,
    RyIssueFileComponent
  ],
  imports: [
    BrowserModule, 
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
