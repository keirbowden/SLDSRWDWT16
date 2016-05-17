/** *****************************************************************************
 * BlogHomeController
 *
 * Description: 
 * 
 * Test class for the custom controller for the Blog demo application created 
 * for the Salesforce World Tour London talk on Responsive App Design with 
 * the Lightning Design System
 *
 * If you are the sort of person who enjoys reading code, you may be interested
 * in a career with BrightGen - check out http://www.brightgen.com or
 * email recruitment@brightgen.com
 *
 * Author Keir Bowden
 * Date 16 May 2016
 *
 * Changes:
 ********************************************************************************/
@isTest
private class BlogHomeController_Test 
{
    @testSetup static void setup()
    {
		Blog_Post__c post=new Blog_Post__c(Body__c='Unit Test Blog Post');
		insert post;
        
    }
    
    @isTest static void TestInitialPosts() 
    {
		List<Blog_Post__c> posts=BlogHomeController.GetInitialPosts();
        System.assertEquals(1, posts.size());
    }

    @isTest static void TestSearchPostsSuccess() 
    {
		List<Blog_Post__c> posts=BlogHomeController.GetInitialPosts();
        Test.setFixedSearchResults(new Id[]{posts[0].id});
        
		posts=BlogHomeController.SearchPosts('Test');
        System.assertEquals(1, posts.size());
    }
    
    @isTest static void TestSearchPostsFail() 
    {
        Test.setFixedSearchResults(new Id[]{});
		List<Blog_Post__c> posts=BlogHomeController.SearchPosts('NotFoundHere');
        System.assertEquals(0, posts.size());
    }
    
    @isTest static void TestAddComment()
    {
		List<Blog_Post__c> posts=BlogHomeController.GetInitialPosts();
        System.assertEquals(0, posts[0].Blog_Post_Comments__r.size());
        BlogHomeController.addComment('Unit Test', 'Test Comment', posts[0].id, System.today());
		posts=BlogHomeController.GetInitialPosts();
        System.assertEquals(1, posts[0].Blog_Post_Comments__r.size());
    }

    @isTest static void TestSetupData()
    {
		List<Blog_Post__c> posts=BlogHomeController.GetInitialPosts();
		
		Folder fld=[select id from Folder where Type='Document' limit 1];
		List<Document> docs=new List<Document>();
		docs.add(new Document(Name='Astro Small', FolderId=fld.id));
		docs.add(new Document(Name='Astro Medium', FolderId=fld.id));
		docs.add(new Document(Name='Astro Large', FolderId=fld.id));
		docs.add(new Document(Name='BrightMedia Small', FolderId=fld.id));
		docs.add(new Document(Name='BrightMedia Medium', FolderId=fld.id));
		docs.add(new Document(Name='BrightMedia Large', FolderId=fld.id));
		
		insert docs;
		
		List<Blog_Post__c> newPosts=BlogHomeController.SetupData();
		
		System.assertEquals(newPosts.size(), posts.size()+2);
    }
}