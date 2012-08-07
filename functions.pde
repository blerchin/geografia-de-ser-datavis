State selectState( State[] list, String name ) {
	ArrayList<State> results = new ArrayList<State>();
	
	for ( State s : list ) {
		if (s.name.compareTo( name ) == 0 ) {
			results.add( s );
			}
	
	}
	if( results.size() > 0 ) 
		return results.get(0);
	else return null;
}