/** *****************************************************************************
 * BlogHomeController
 *
 * Description: 
 * 
 * Custom controller for the Blog demo application created for the Salesforce 
 * World Tour London talk on Responsive App Design with the Lightning Design 
 * System
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
public class BlogHomeController 
{
	@AuraEnabled
    public static List<Blog_Post__c> GetInitialPosts()
    {
        return GetPosts(null);
    }
    
    private static List<Blog_Post__c> GetPosts(List<Blog_Post__c> postIds)
    {
        String queryStr='select id, Name, Body__c, Author__c, Published_Date__c, ' + 
                        ' Comment_Count__c, Large_Image_ID__c, Medium_Image_ID__c, ' +
            			' Small_Image_ID__c, ' +
            			' (select Id, Comment__c, Author__c, Date__c ' + 
                        '  from Blog_Post_Comments__r ' + 
                        '  order by Date__c desc, CreatedDate desc ) ' +
                        ' from Blog_Post__c ';
           
        if (null!=postIds)
        {
            queryStr+=' where id in :postIds';
        }
        
        queryStr+=' order by Published_Date__c desc ' + 
                  ' limit 3';

        List<Blog_Post__c> posts=Database.query(queryStr);
        System.debug('Got posts ' + posts);
		return posts;
    }

	@AuraEnabled
    public static List<Blog_Post__c> SearchPosts(String searchString)
    {
		List<List<Blog_Post__c>> allObjs=[find :searchString returning Blog_Post__c(id) limit 5];
		return GetPosts(allObjs[0]);
    }
    
	@AuraEnabled
    public static void AddComment(String name, String comment, String postId, Date theDate)
    {
        Blog_Post_Comment__c bc=new Blog_Post_Comment__c(Author__c=name, Comment__c=comment, Blog_Post__c=postId,
                                                        Date__c=Date.today());
		System.debug('the date = ' + theDate);
        insert bc;
    }

	@AuraEnabled
	public static List<Blog_Post__c> SetupData() 
	{
		List<Blog_Post__c> posts=new List<Blog_Post__c>();
		
		Blog_Post__c astroPost=new Blog_Post__c(Name='Where\'s Astro', 
												Body__c='Attention, Trailblazers! Code habanero alert!'  +
												        ' 🌶Our beloved mascot Astro has gone missing ' +
												        ' and might be in grave danger.Team Trailhead' + 
												        ' needs your help to solve the mystery. We\'ll' + 
												        ' need the entire Trailblazer community to bring' + 
												        ' Astro home safely—that means YOU!  Are you ready?', 
												Author__c='Trailhead', 
												Published_Date__c=Date.newInstance(2016, 4, 1));
		posts.add(astroPost);

		Blog_Post__c bgmPost=new Blog_Post__c(Name='BrightMedia', 
												Body__c='BrightMedia is an end-to-end solution for cross-media' + 
												' ad sales. It solves many challenges faced by the media industry' +
												' today by integrating Salesforce into the advertising sales process, ' +
												' managing advertising orders from quotation through to fulfillment ' + 
												' and billing. This proven solution can provide faster and more ' + 
												' predictable deployments for customers, empowering them to transform ' +
												' their processes and connect with customers in entirely new ways.', 
												Author__c='Keir Bowden', 
												Published_Date__c=Date.newInstance(2016, 3, 7));

		posts.add(bgmPost);

		// set up the images - oh for a switch statement!
		for (Document doc : [select id, Name from Document])
		{
			if (doc.Name=='Astro Small')
			{
				astroPost.Small_Image_ID__c=doc.id;
			}
			else if (doc.Name=='Astro Medium')
			{
				astroPost.Medium_Image_ID__c=doc.id;
			}
			else if (doc.Name=='Astro Large')
			{
				astroPost.Large_Image_ID__c=doc.id;
			}
			else if (doc.Name=='BrightMedia Small')
			{
				bgmPost.Small_Image_ID__c=doc.id;
			}
			else if (doc.Name=='BrightMedia Medium')
			{
				bgmPost.Medium_Image_ID__c=doc.id;
			}
			else if (doc.Name=='BrightMedia Large')
			{
				bgmPost.Large_Image_ID__c=doc.id;
			}
		}
		
		insert posts;
		
		return GetInitialPosts();
	}
}