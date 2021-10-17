let template = `
<div class="table-responsive">
	<table class="table table-striped table-sm">
	  <thead>
			<tr>
			  <th scope="col">Line</th>
			  <th scope="col">Data</th>
			  <th scope="col">Issue</th>
			</tr>
	  </thead>
	  <tbody>
			<tr *ngFor="let item of list">
			  <td>{{ item.line }}</td>
			  <td>{{ item.data_row }}</td>
			  <td>{{ item.issues }}</td>
			</tr>
	  </tbody>
	</table>
	<div class="p-3">
		<button type="button" 
			(click)="back()" 
			*ngIf="meta.offset!==meta.limit" 
			class="btn btn-secondary">Back</button>
		<button type="button" 
			*ngIf="list.length >= meta.limit" 
			(click)="next()" 
			class="btn float-end btn-secondary">Next</button>
	</div>
</div>
`;
export {template};