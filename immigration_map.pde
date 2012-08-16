import processing.pdf.*;

import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;

RSVG rsvg;
RGroup usMap;

State[] states;

Fader animateFill;

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
  animateFill = new Fader(20);
  
  
  drawFlag = true;

  
}

void draw() {
  
if( drawFlag ) {
          float fader = animateFill.val();
        
          selectState( states, "CA").fillToPercent( fader * 75 );
          selectState( states, "NV").fillToPercent( fader * 7 );
          selectState( states, "TX").fillToPercent( fader * 76 );
          selectState( states, "AZ").fillToPercent( fader * 6 );
          selectState( states, "NJ").fillToPercent( fader * 6 );
          selectState( states, "MD").fillToPercent( fader * 5 );
          selectState( states, "FL").fillToPercent( fader * 10 );
          selectState( states, "GA").fillToPercent( fader * 40 );
          selectState( states, "OR").fillToPercent( fader * 35 );
          selectState( states, "DC").fillToPercent( fader * 4 );
          selectState( states, "NM").fillToPercent( fader * 13 );
          selectState( states, "IL").fillToPercent( fader * 4 );
          selectState( states, "LA").fillToPercent( fader * 95 );
          selectState( states, "AR").fillToPercent( fader * 50 );
          selectState( states, "ID").fillToPercent( fader * 50 );
    
  
  
	
	  for( int s = 0; s < states.length; s++ ) {
			//println("drawing " + states[s].name);
			states[s].drawSlices();
			states[s].drawBorders();
	  }

  animateFill.increment();
  
  drawFlag = false;  
  if( animateFill.val() <1 )
      drawFlag = true;

  }
  
  
}


