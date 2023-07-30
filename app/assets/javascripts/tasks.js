import {turbolinks} from turbolinks
document.addEventListener('turbolinks:load', function() {
    console.log('Loaded');
})

document.addEventListener('turbolinks;load', function(){
    document.querySelectorAll('td').forEach(function(td){
        td.addEventListener('mouseover', function(e){
            e.currentTarget.style.backgroundColor = '#eff';
        });
        
        td.addEventListener('mouseout', function(e){
            console.log("MOUSE OUT");
            e.currentTarget.style.backgroundColor = ''
        })
    })
})
