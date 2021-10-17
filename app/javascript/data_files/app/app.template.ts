let template = `
<div class="table-responsive">
	<table class="table table-striped table-sm">
	  <thead>
			<tr>
			  <th scope="col">#</th>
			  <th scope="col">Filename</th>
			  <th scope="col">S3</th>
			  <th scope="col">Status</th>
			</tr>
	  </thead>
	  <tbody>
			<tr *ngFor="let item of list">
			  <td>{{ item.id }}</td>
			  <td>{{ item.filename }}</td>
			  <td>{{ item.s3_path }}</td>
			  <td>{{ item.status }}</td>
			  <td >
			  	<a href="/data_file/{{ item.id }}/" 
			  		target="_blank" 
			  		*ngIf="item.status !== 'hold'" class="btn btn-danger">
			  		Summary
			  	</a>
			  </td>
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