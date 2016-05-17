({
    loadInitialPosts : function(cmp, ev) {
        try
        {
            var action = cmp.get("c.GetInitialPosts");
            var self = this;
            action.setCallback(this, function(response) {
                self.actionResponseHandler(response, cmp, self, self.gotPosts, true);
            });
            $A.enqueueAction(action);
            
        }
        catch (e) 
        {
            alert('Exception in loadInitialPosts ' + e + ', ' + e.stack);
        }
    },
    search : function(cmp, ev) {
        try
        {
            var searchString=ev.getParam('searchString');
            if ( (undefined!=searchString) && (searchString.length > 0) ) {
	            var action = cmp.get("c.SearchPosts");
    	        action.setParams({searchString: searchString});
        	    var self = this;
            	action.setCallback(this, function(response) {
                	self.actionResponseHandler(response, cmp, self, self.gotPosts, false);
	            });
    	        $A.enqueueAction(action);
            }
        }
        catch (e) 
        {
            alert('Exception in search ' + e + ', ' + e.stack);
        }
    },
    resetSearch : function(cmp, ev) {
        this.loadInitialPosts(cmp, ev);
    },
    comment : function(cmp, ev) {
        try
        {
            var action = cmp.get("c.AddComment");
            var theDate=new Date();
            var name=ev.getParam('name');
            var comment=ev.getParam('comment');
            var postId=ev.getParam('postId');
            action.setParams({name: name,
                              comment: comment,
                              postId : postId
                             });
            var newComment={Author__c:name, Comment__c:comment, Date__c:new Date().toISOString().substr(0, 10)};
            var posts=cmp.get('v.posts');
            for (var idx=0, postsLen=posts.length; idx<postsLen; idx++)
            {
                if (posts[idx].Id===postId) {
                    if (undefined==posts[idx].Blog_Post_Comments__r) {
						posts[idx].Blog_Post_Comments__r=[];
                        posts[idx].Comment_Count__c=0;
                    }
                    posts[idx].Blog_Post_Comments__r.unshift(newComment);
                    posts[idx].Comment_Count__c++;
                    break;
                }
            }
            cmp.set('v.posts', posts);
            var self = this;
            action.setCallback(this, function(response) {
                self.actionResponseHandler(response, cmp, self, self.commentAdded);
            });
            $A.enqueueAction(action);
        }
        catch (e) 
        {
            alert('Exception in comment ' + e + ', ' + e.stack);
        }
    },
    actionResponseHandler : function (response, component, helper, cb, cbData) {
        try
        {
            var state = response.getState();
            if (state === "SUCCESS") {
                var retVal=response.getReturnValue();
                console.log('Result = ' + JSON.stringify(retVal));
                cb(component, helper, retVal, cbData);
                console.log('Done with callback');
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    console.log("Errors", errors);
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + errors[0].message);
                    }
                } 
                else {
                    alert("Unknown error");
                }
            }
        }
        catch (e) {
            alert('Exception in actionResponseHandler: ' + e + '\n' + e.stack);
            
        }
    },
    createPosts : function(cmp, ev) {
        try
        {
            var action = cmp.get("c.SetupData");
            var self = this;
            action.setCallback(this, function(response) {
                self.actionResponseHandler(response, cmp, self, self.gotPosts, false);
            });
            $A.enqueueAction(action);
            
        }
        catch (e) 
        {
            alert('Exception in createPosts ' + e + ', ' + e.stack);
        }
    },

    gotPosts : function(cmp, helper, result, checkSize) {
        if ( (checkSize) && (0==result.length) ) {
            cmp.set('v.noPosts', true);
        }
        else {
            cmp.set('v.noPosts', false);

        }
        for (var idx=0, len=result.length; idx<len; idx++) {
            result[idx].hideComments=true;
        }
        cmp.set('v.posts', result);
    },
    commentAdded : function(cmp, helper, result) {
        // notify here if required
    },
    navigateToLinks : function(cmp, ev) {
        try {
	        sforce.one.navigateToURL('/c/BlogLinksApp.app');
        }
        catch (exc) {
            window.location="/c/BlogLinksApp.app";
        }
    }
})