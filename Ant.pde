class Ant {
  /*
    After a long period of hibernation, these ants leave the 
    Colony to gather some food for Queen Ant...
  
    When an ant finds food, it brings it back to the Colony
    and leaves pheromones behind it so that other ans can find
    the same food spot.
    
    There's only one public attribute : Run(). Ants are fully
    autonomous and communicate solely via pheromones. 
  */ 
  
  // An ant can only carry a single unit of food
  private boolean _carriesFood;   
  // Current position in the grid
  private Tile _currentTile;
  // Position of the Colony
  private Tile _colony;
  // Food whereabouts pheromone 
  private Pheromone _pheromone;
  private Grid _grid;
  // Direction followed when randomly searching
  private int xRand;
  private int yRand;
    
  Ant(Grid g, Tile Colony) {
    _carriesFood = false;
    _grid = g;
    _colony = Colony;
    _currentTile = Colony;
    RandomDirection();
  }
  
  // Choose a new direction for random searching
  // Directions are either (1,1), (1,0), (1,-1), (0,1)
  // (-1, 1), (-1, 0), (-1, -1), or (0, -1)
  private void RandomDirection() {
    xRand = (int) random(0, 3) - 1;
    yRand = (int) random(0, 3) - 1;    

    if (xRand == 0 && yRand == 0)
      RandomDirection();
  }
  
  // If there's food on the current tile, take it
  private void TakeFood() {
    // Create a new pheromone indicating the current tile (food spot)
    _pheromone = new Pheromone(_currentTile);
    _carriesFood = true;
    _currentTile.TakeFood();
  }
  
  private void DropFood() {
    _carriesFood = false;  
  }
  
  // If the ant carries food, drop pheromone sharing the whereabouts of the
  // food spot on the current tile
  private void DropPheromone() {
    _currentTile.DropPheromone(_pheromone); 
  }
  
  // If the ant carries food, go back to the Colony
  private void GoHome() {
    DropPheromone();
    FindPath(_colony);    
    // If we get to the Colony, no slacking off, little ant gets back to work
    if (_currentTile.equals(_colony))
      DropFood();
  }
  
  // Randomly search for a food spot, or follow pheromones
  private void SearchForFood() {
    // It there's food on the current tile, take it
    if (_currentTile.HasFood) {
      TakeFood();
      return;
    }
    // If there's pheromones, follow them
    else if (_currentTile.HasPheromone && 
            _currentTile.GetPheromone().GetTile() != _currentTile) {
      FindPath(_currentTile.GetPheromone().GetTile());
      return;
    }  
    // If there's neither, random search
    else {
      RandomDirection();
      int x = _currentTile.x + xRand;
      int y = _currentTile.y + yRand;
      try {
        Move(_grid.tiles[x][y]);
      }
      catch (ArrayIndexOutOfBoundsException e) {
        // If the randomly chosen case does not exist, we just lazily 
        // call the same function again
        SearchForFood();
      }
    }   
  }
  
 // If the ant is not searching but instead heads to a known destination
 // (Colony or Food spot), get the path to the objective
  private void FindPath(Tile destination) {
    // Get the direction vector and normalize it
    int xDir = destination.x - _currentTile.x;
    int yDir = destination.y - _currentTile.y;
    int xPos = (xDir > 0) ? 1 : -1;
    int yPos = (yDir > 0) ? 1 : -1;
    try {
      if (abs(xDir) > abs(yDir) && xDir != 0)
        Move(_grid.tiles[_currentTile.x + xPos * xDir / xDir][_currentTile.y]);
      else if (yDir != 0)
        Move(_grid.tiles[_currentTile.x][_currentTile.y + yPos * yDir / yDir]);
      }
     catch (ArrayIndexOutOfBoundsException e) {
       // Lazy.
    }
  }
  
  // Move to another tile
  private void Move(Tile t) {
    _currentTile.AntLeaving();
    _currentTile = t;
    t.AntComing();
  }
  
  // Basic behaviour : if the ant carries food, it brings it back to the
  // colony, else it gets to work and go look for food for Queen Ant
  public void Run() {
    if (_carriesFood)
      GoHome();
    else 
      SearchForFood();  
  }
}
