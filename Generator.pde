class Generator {
  /*
    Spawns the ants at the colony, and the food spots.
  */
  private int _width;
  private int _height;
  private Grid _grid;
  
  public Ant[] ants;
  
  Generator(int _w, int _h, Grid _g) {
    _width = _w;
    _height = _h;
    _grid = _g;
  }
  
  public void Generate(int nbAnts, int nbFoodSpots) {    
    GenerateAnts(nbAnts);    
    GenerateFoodSpots(nbFoodSpots);
  }
  
  private void GenerateAnts(int nbAnts) {
    ants = new Ant[nbAnts];
    // Randomly choose the Colony's coordinates
    int xColony = (int) random(_width);
    int yColony = (int) random(_height);
    _grid.tiles[xColony][yColony].IsColony = true;
    
    // Spawn the ants at the Colony
    for (int i = 0; i < nbAnts; i++) {
      Ant a = new Ant(_grid, _grid.tiles[xColony][yColony]); 
      _grid.tiles[xColony][yColony].AntComing();
      ants[i] = a;
    }
  }
  
  private void GenerateFoodSpots(int nbFoodSpots) {
    int xFoodSpot;
    int yFoodSpot;    
    Tile t;

    for (int i = 0; i < nbFoodSpots; i++) {
        xFoodSpot = (int) random(_width);
        yFoodSpot = (int) random(_height);
        t = _grid.tiles[xFoodSpot][yFoodSpot];
        t.PutFood();
    }    
  }
  
}
