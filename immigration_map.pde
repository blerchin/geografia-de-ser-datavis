import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;

RSVG rsvg;
RGroup usMap;

State[] states;

boolean drawFlag;

void setup() {
  size(1000, 600);
  smooth();
  
  background(255);
  
  RG.init(this);
  
  RSVG rsvg = new RSVG(); 
  RGroup usMap = new RGroup();
  usMap = rsvg.toGroup("america.svg");
  
  // get state names and draw the corresponding shape
  // (all states are path elements and all path elements are states)
  XMLElement[] stateMeta = new XMLElement(this, "america.svg").getChildren( "path" );
  
  states = new State[ stateMeta.length ]; 
  println("number of states is: " + stateMeta.length );
  
  for( int i = 0; i < stateMeta.length; i++ ) {
  	// create a new State obj in array with shape from SVG and corresponding name 
 	states[i] = new State( usMap.elements[i], stateMeta[i].getString( "id" ) );
 	}
  
  selectState( states, "CA").fillToPercent( 75 );
  selectState( states, "NV").fillToPercent( 7 );
  selectState( states, "TX").fillToPercent( 7 );
  selectState( states, "AZ").fillToPercent( 6 );
  selectState( states, "NJ").fillToPercent( 6 );
  selectState( states, "MD").fillToPercent( 5 );
  selectState( states, "FL").fillToPercent( 4 );
  selectState( states, "GA").fillToPercent( 4 );
  selectState( states, "OR").fillToPercent( 4 );
  selectState( states, "DC").fillToPercent( 4 );
  selectState( states, "NM").fillToPercent( 4 );
  selectState( states, "IL").fillToPercent( 4 );
  
  
  drawFlag = true;

  
}

void draw() {
  
if( drawFlag ) {
	  /*
	  for( State s : states ) {
			s.fillToPercent( floor( 100 * random(1) ) );
	  }
	  */
	
	  for( int s = 0; s < states.length; s++ ) {
			println("drawing " + states[s].name);
			states[s].drawSlices();
			states[s].drawBorders();
	  }
  drawFlag = false;
  }
  
  
}


