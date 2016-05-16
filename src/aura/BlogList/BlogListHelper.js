({
    addComment : function(cmp, ev) {
        var name=cmp.get('v.newCommentName');
        var comment=cmp.get('v.newCommentDetail');
        var postId=ev.target.id;
        var action=$A.get('e.c:BlogCommentEvt');
        action.setParams({name:name,
                          comment:comment,
                          postId:postId});
        action.fire();
        cmp.set('v.newCommentName', '');
        cmp.set('v.newCommentDetail', '');
    },
    toggleComments : function(cmp, ev) {
        var postId=ev.target.id.substring(7);
        var posts=cmp.get('v.posts');
        for (var idx=0, postsLen=posts.length; idx<postsLen; idx++)
        {
            if (posts[idx].Id===postId) {
                posts[idx].hideComments=!posts[idx].hideComments;
                break;
            }
        }
        cmp.set('v.posts', posts);
    }
})