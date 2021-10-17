let template = `
<div >
	<div class="card mt-4">
    	<div class="card-header">
    		Contacts recorded
    	</div>
    	<div class="card-body">
            <ry-contacts [data_file]="id"></ry-contacts>
    	</div>
    </div>
	<div class="card mt-4">
    	<div class="card-header">
    		Contacts issued
    	</div>
    	<div class="card-body">
            <ry-issue-files [data_file]="id"></ry-issue-files>
    	</div>
    </div>
</div>
`;
export {template};