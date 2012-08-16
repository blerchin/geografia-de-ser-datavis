class State {

  RShape outline;
  RGroup slices;
  String name;
  RStyle emptyStyle;
  RStyle fullStyle;
  float percentFull;

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
    if ( slices != null ) {
      return slices;
    } 
    else {
      //println( "slicing state " + name );
      RGroup newSlices = new RGroup();

      int height = floor( outline.getHeight());
      int width = floor( outline.getWidth());
      float px =  outline.getX();
      float py = outline.getY();


      for ( int y = height; y > 0 ; y--) { //looping backward so we can fill slices from the bottom.
        float y0 = y; //find rect position proportional to state size
        float y1 = (y+2) ;

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

  void fillToPercent( float percent ) {
    percentFull = percent;
    updateStyle();
  }



  void updateStyle() {
    float leftToFill = ( percentFull/100) * getRoughArea();
    //println(name +"area= "+getRoughArea() );

    //int slicesToFill = floor( percentFull * outline.getHeight() / 100 );
    int i = 0;
    
    while ( leftToFill > 0 & i<slices.elements.length ) {
      slices.elements[i].setStyle( fullStyle);
      leftToFill -= getSafeWidth( slices.elements[i] );
      //println(name+i+" "+getSafeWidth( slices.elements[i] )+", "+ leftToFill );
      i++;
    }
  }
  
  // geomerative built in getWidth() returns infinity values when a
  // shape is really small. Check for those errors and return zero when they occur.
  float getSafeWidth( RGeomElem shape ) {
       float theWidth = shape.getWidth() ; 
      //check if slice is positive. occasionally result is -/+Infinity
      if( theWidth !=Float.POSITIVE_INFINITY && 
              theWidth !=Float.NEGATIVE_INFINITY &&
              theWidth > 0.1){
              return theWidth;
         } else return 0.f;
              
  }
  
  float getRoughArea() {
    float area = 0.f;
    for( RGeomElem slice : slices.elements) {
      area += getSafeWidth(slice);
   }
   
   return area;
    
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

