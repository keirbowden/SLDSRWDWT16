({
	navigateToHome : function(cmp, ev) {
        try {
	        sforce.one.navigateToURL('/c/BlogHomeApp.app');
        }
        catch (exc) {
            window.location="/c/BlogHomeApp.app";
        }
	}
})