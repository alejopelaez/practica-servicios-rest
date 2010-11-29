candidatos = { "jojoy" : 0, "piedad" : 0, "reyes" : 0 };
totales = {};
jQuery.extend({
    Controller: function(model, view){
        /**
         * Escucha a la vista
         */
        var vlistener = $.ViewListener({
            viewLoadData : function(key){
		//Inicializa los hashes
		candidatos = { "jojoy" : 0, "piedad" : 0, "reyes" : 0 };
		totales = {};
                var all = model.getAll(key);
            }
        });
        view.addListener(vlistener);

        /**
         * Función llamada cuando se terminan todos los
         * requests.
         */
	/*$("#key").ajaxStop(function(){
            view.show("Done!!");
            
	    var arr = jQuery("#resultTable").find('[class]');
	    $.each(arr,function(index, value){
	    	var param = $(value).attr('class').split(" ");
	    	var t = param[0];
	    	for(var i = 1; i < param.length - 1; ++i)
	    	    t+=" "+param[i];
	    	var subTotal = helper(t);
	    	view.crearPie(subTotal, param[0]);
	    });	    
        });*/

        /**
         * listen to the model
         */
        var mlist = $.ModelListener({
            onLoadBegin : function(){
                view.show("Cargar datos del modelo...");
            },
            onLoadEnd : function(info){
                //extraiga los datos

		totales = info;
            }
        });
        model.addListener(mlist);
    }
});