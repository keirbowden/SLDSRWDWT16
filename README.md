# SLDSRWDWT16

This is the codebase behind my responsive apps with the lightning design system talk at the 2016 Salesforce1 World Tour in London.

## My Domain
Don't forget that Lightning Components requires My Domain, so you need to turn that on first.

## Managed Package
While all the components are here and you can drop them into your Saleforce org, its easier (particularly where Lightning Components are concerned) to install the managed package from :

https://login.salesforce.com/packaging/installPackage.apexp?p0=04t58000000Qyeu


## Blog Posts
Managing Blog Posts is much easier when you have a custom tab, so I'd recommend you create one of these once you have the package or code installed.

## Image Fields
The the Small/Medium/Large Image Id fields need the id of a Document or the id of an Attachment (NOTE - not the new Files based attachments, but the old Attachment object itself).  

To find out the Document id, click the View File link on the document page and grab the URL, e.g. :

https://kabtalks16-dev-ed--c.eu6.content.force.com/servlet/servlet.FileDownload?file=01558000000dSus

the id is everything after the file=, so in this case 01558000000dSus

## Blog App
You can access the blog posts via the 'BlogHomeApp' Lightning component application, which will have a URL similar to

https://<your_domain>.lightning.force.com/c/BlogHomeApp.app

Have fun!
