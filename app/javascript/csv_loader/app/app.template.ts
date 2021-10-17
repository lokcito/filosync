let template = `
<div>
	<div *ngIf="requestStatus==='running'" class="">
		<div  class="text-center alert alert-danger">
			Loading...
		</div>
	</div>
	<div *ngIf="requestStatus==='done'" class="">
		<div  class="text-center alert alert-danger">
			The file was processed, please click 
			<a href="/data_file/{{lastFile}}/" 
				target="_blank">here to see details.</a>
		</div>
	</div>
	<div *ngIf="requestStatus!=='running'" class="">
		<div class="card">
			<div class="card-header">
				Please select a CSV File:
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<input type="file" accept=".csv" 
							(change)="handleFileSelect($event)">
					</div>
					<div class="col-xs-12 col-sm-6">
						<div class="list-group">
						  <div class="list-group-item">
								File name: {{this.name}}
						  </div>
						  <div class="list-group-item">
								File Size: {{this.size}}
						  </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div *ngIf="fileLoaded" class="card mt-4">
			<div class="card-header">
				Content found on your file
				<button *ngIf="areColsDefined" 
					type="button" 
					(click)="startToRecord()"
					class="float-end btn btn-primary">
					Save records
				</button>
			</div>
			<div class="card-body">
				<div *ngIf="!areColsDefined" class="alert alert-primary">
					Please before to save rows, select the columns 
					to match your data.
				</div>
			  <div class="table-responsive">
				  <table class="table table-striped table-sm" >
					<thead>
					  <tr>
							<th>
								<col-selector [cols]="cols" 
									[defined]="definedCols"
									(onSelected)="changeCols($event)"
									[position]="0"></col-selector>
							</th>
							<th>
								<col-selector [cols]="cols" 
									[defined]="definedCols"
									(onSelected)="changeCols($event)"
									[position]="1"></col-selector>
							</th>
							<th>
								<col-selector [cols]="cols" 
									[defined]="definedCols"
									(onSelected)="changeCols($event)"
									[position]="2"></col-selector>
							</th>
							<th>
								<col-selector [cols]="cols" 
									[defined]="definedCols"
									(onSelected)="changeCols($event)"
									[position]="3"></col-selector>
							</th>
							<th>
								<col-selector [cols]="cols"
									[defined]="definedCols"
									(onSelected)="changeCols($event)"
									[position]="4"></col-selector>
							</th>
							<th>
								<col-selector [cols]="cols"
									[defined]="definedCols"
									(onSelected)="changeCols($event)"
									[position]="5"></col-selector>
							</th>
							<th>
								<col-selector [cols]="cols"
									[defined]="definedCols" 
									(onSelected)="changeCols($event)"
									[position]="6"></col-selector>
							</th>
							<th></th>
					  </tr>
					</thead>
					<tbody>
					  <tr *ngFor="let row of this.clines">
							<td *ngFor="let col of row.cols">{{ col }}</td>
							<td>{{ row.status }}</td>
					  </tr>
					</tbody>
				  </table>
				</div>
			</div>
		</div>
	</div>
</div>    
`
export {template};