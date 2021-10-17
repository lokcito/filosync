let template = `
<div class="table-responsive">
	<table class="table table-striped table-sm">
	  <thead>
			<tr>
			  <th scope="col">Name</th>
			  <th scope="col">Date of Birth</th>
			  <th scope="col">Phone</th>
			  <th scope="col">Address</th>
			  <th scope="col">Credit Card</th>
			  <th scope="col">Franchise</th>
			  <th scope="col">Email</th>
			</tr>
	  </thead>
	  <tbody>
			<tr *ngFor="let item of list">
			  <td>{{item.name }}</td>
			  <td>{{ item.date_of_birth }}</td>
			  <td>{{ item.phone }}</td>
			  <td>{{ item.address }}</td>
			  <td>{{ item.credit_card }}</td>
			  <td>{{ item.franchise }}</td>
			  <td>{{ item.email }}</td>
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