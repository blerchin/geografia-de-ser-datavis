class State  {
  
  RShape outline;
  RGroup slices;
  String name;
  RStyle emptyStyle;
  RStyle fullStyle;
  int percentFull;
  
  State( RGeomElem stateShape, String id ) {
    name = id;
    outline = stateShape.toShape();
    slices = getSlices();

    //make copies of the styles so we don't affect the default with later changes
	emptyStyle = new RStyle( defaultEmptyStyle() ); 
	fullStyle = new RStyle( defaultFullStyle() );
	updateStyle();
		
  }
  
  RGroup getSlices() {
    if( slices != null ) {
        return slices;
    } else {
    	//println( "slicing state " + name );
    	RGroup newSlices = new RGroup();
    	
    	int height = floor( outline.getHeight());
    	int width = floor( outline.getWidth());
    	float px =  outline.getX();
    	float py = outline.getY();
    	
    	  	
        for( int y = height; y > 0 ; y--) { //looping backward so we can fill slices from the bottom.
            float y0 = y; //find rect position proportional to state size
			float y1 = (y+1) ;
			
			RShape slicer = RShape.createRectangle( px, y0+py, width, y1-y0);

			// create a new RShape with at intersection of slicer rect and 
			// containing shape.
			RShape slice = new RShape( outline.intersection( slicer ) ); 
			newSlices.addElement( slice );
			}
		//println( "height of state " + height);
		//println( "number of slices: " + newSlices.elements.length );
        return newSlices;
        }	
    }
    
   void drawSlices() {
   		slices.draw();
   }
   void drawBorders() {
		outline.setFill( false );
		outline.setStroke("#000000");
		outline.setStrokeWeight(1);
		outline.draw();   
   }
   
   void fillToPercent( int percent ){
   		percentFull = percent;
   		updateStyle();
   }
   
   void updateStyle() {
   		int slicesToFill = floor( percentFull * outline.getHeight() / 100 );
   		for( int i = 0; i < slices.elements.length; i++) {
   			if( i <= slicesToFill) {
   				slices.elements[i].setStyle( fullStyle);
   				} else {
   				slices.elements[i].setStyle( emptyStyle);
   				}
   		}
   }
   
   
   RStyle defaultEmptyStyle() {
   		RStyle style = new RStyle();
   		style.setFill(false);
   		style.setStroke(false);
	   	return style;
   }
   RStyle defaultFullStyle() {
   		RStyle style = new RStyle();
   		style.setFill(true);
   		style.setFill("#c0c4de");
   		style.setStroke(false);
   		return style;
   }
   
   void setNewEmptyStyle( RStyle newStyle ) {
   		emptyStyle = new RStyle( newStyle);
	}
   void setNewFullStyle( RStyle newStyle ) {
   		fullStyle = new RStyle( newStyle);
	}
  
}
