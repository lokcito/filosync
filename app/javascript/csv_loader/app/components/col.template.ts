let template = `
<div [formGroup]="colForm">
    <select class="form-control" (change)="change($event)" 
    	formControlName="col">
       <option value="" disabled>Please select</option>
       <option *ngFor="let col of _cols" 
        [ngValue]="col">{{col}}</option>
    </select>
    <a class="text-danger" (click)="remove()">Remove</a>
</div>
`;
export {template};