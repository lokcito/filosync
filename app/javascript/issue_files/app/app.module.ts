import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

import { RyContactComponent } from './app.component';

@NgModule({
  declarations: [
    RyContactComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [RyContactComponent]
})
export class AppModule { }
