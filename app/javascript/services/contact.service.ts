import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { HttpClientModule } from '@angular/common/http';
import { Meta, MetaDefinition } from '@angular/platform-browser';

@Injectable({
  providedIn: 'root'
})

export class ContactService{
  headers:any;
  constructor(private http: HttpClient,
    private metaService: Meta) {
    this.headers = new HttpHeaders({
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-CSRF-Token': this.metaService.getTag("name=csrf-token").getAttribute("content")
    });
  }

  getFormUrlEncoded(toConvert) {
    const formBody = [];
    for (const property in toConvert) {
      if ( toConvert[property] === undefined ) {
              continue;
      }
      const encodedKey = encodeURIComponent(property);
      const encodedValue = encodeURIComponent(toConvert[property]);
      formBody.push(encodedKey + '=' + encodedValue);
    }
    return formBody.join('&');
  }

  create(data:any) {
    return this.http.post("/contact.json",
      this.getFormUrlEncoded(data),
      {'headers': this.headers});
  }

  filter(data:any) {
    return this
      .http
      .get("/contact/_filter", {params: data});
  }
}