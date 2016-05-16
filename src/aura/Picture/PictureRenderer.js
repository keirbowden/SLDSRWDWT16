({
    render: function(component, helper) {
        //grab attributes from the component markup
        var media1 = component.get("v.source1media");
        var srcset1 = component.get("v.source1srcset");
        var media2 = component.get("v.source2media");
        var srcset2 = component.get("v.source2srcset");
        var media3 = component.get("v.source3media");
        var srcset3 = component.get("v.source3srcset");
        var imagesrc = component.get("v.imagesrc");

        //return a Picture element with the attributes
        var picture = document.createElement("Picture");
        var source1 = document.createElement("source");
        source1.setAttribute('media', media1);
        source1.setAttribute('srcset', srcset1);
        picture.appendChild(source1);
        if (null!=media2) {
        	var source2 = document.createElement("source");
	        source2.setAttribute('media', media2);
    	    source2.setAttribute('srcset', srcset2);
	        picture.appendChild(source2);
        }
        var img=document.createElement("img");
        img.setAttribute("src", imagesrc);
        img.setAttribute("style", "max-width:100%");
	    picture.appendChild(img);
        return picture;
    }
})