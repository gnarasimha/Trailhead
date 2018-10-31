({
    init: function (cmp, event, helper) {
              
         cmp.set('v.columns', [
            {label: 'Job Id', fieldName: 'JobId', type: 'text'},
            {label: 'Submitted By', fieldName: 'SubmittedBy', type: 'text'},
            {label: 'Start Time', fieldName: 'StartTime', type: 'text'},
            {label: 'Status', fieldName: 'Status', type: 'text'},
            {label: 'Job Type', fieldName: 'JobType', type: 'text'},
            {label: 'Operation', fieldName: 'Operation', type: 'text'},
            {label: 'Object', fieldName: 'Object', type: 'text'}
      
        ]);
    },

   
})