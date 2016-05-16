({
	search : function(cmp, ev) {
        var searchString=cmp.get('v.searchString');
        var action=$A.get('e.c:BlogSearchEvt');
        action.setParams({searchString:searchString});
        action.fire();
	},
	resetSearch : function(cmp, ev) {
        cmp.set('v.searchString', '');
        var action=$A.get('e.c:ResetSearchEvt');
        action.fire();
	}
})