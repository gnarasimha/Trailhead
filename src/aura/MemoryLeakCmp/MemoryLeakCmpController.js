({ 
    handleClickPopulate: function (c, e, h) { 
        var d = new Date();
        var n = d.getTime();
        var root = []; 
        console.log('startTime' + n);
        for (var i = 0; i < 50; i++) { 
            var branch = []; 
            for (var j = 0; j < 50; j++) { 
                branch.push('hello_world '); 
            } 
            root.push(branch); 
        } 
        c.set('v.root', root); 
        var d1 = new Date();
        var n1 = d1.getTime();
         console.log('EndTime' + n1);
         var totalTime = n1-n;
         console.log('TotalTimeinMs' + totalTime);
    }, 
    
    handleClickClear: function (c, e, h) { 
        var root = []; 
        c.set('v.root', root); 
    } 
})